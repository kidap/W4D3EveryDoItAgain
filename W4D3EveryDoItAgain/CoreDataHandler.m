//
//  CoreDataHandler.m
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "CoreDataHandler.h"
#import "CoreData/CoreData.h"
#import "User.h"
#import "ToDo.h"

@implementation CoreDataHandler
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+(instancetype)sharedInstance{
  static CoreDataHandler *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  
  return sharedInstance;
}
-(NSURL *)applicationDocumentsDirectory{
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(NSManagedObjectContext *)managedObjectContext{
  if (_managedObjectContext != nil){
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  }
  
  return _managedObjectContext;
}
-(NSManagedObjectModel *)managedObjectModel{
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EveryDoModel" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  
  return _managedObjectModel;
}
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  NSError *error = nil;
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"EveryDoModel.sqlite"];
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    NSLog(@"Error: %@ %@.", error, [error userInfo]);
    abort();
  }
  NSLog(@"%@",storeURL);
  
  return _persistentStoreCoordinator;
}
-(void)dealloc{
}

- (void)saveContext {
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}
//MARK: Data methods
-(NSFetchedResultsController *)getAllUsers{
  NSError *error= nil;
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES];
  fetchRequest.sortDescriptors = @[sortDescriptor];
  
  NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                      managedObjectContext:self.managedObjectContext
                                                                        sectionNameKeyPath:nil
                                                                                 cacheName:nil];
  [fetchedResultsController performFetch:&error];
  
  return fetchedResultsController;
}
-(User *)getUserWithUsername:(NSString *)username{
  NSError *error= nil;
  NSString *fieldName = @"username";
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
  
  //Sorting
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES];
  fetchRequest.sortDescriptors = @[sortDescriptor];
  
  //Filterting
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@",fieldName,username];
  fetchRequest.predicate = predicate;
  
  NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                             managedObjectContext:self.managedObjectContext
                                                                                               sectionNameKeyPath:nil
                                                                                                        cacheName:nil];
  [fetchedResultsController performFetch:&error];
  
  return [fetchedResultsController.fetchedObjects lastObject];
}

-(NSFetchedResultsController *)getAllToDoForUser:(User *)user{
  NSError *error= nil;
  NSString *fieldName = @"user.username";
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ToDo"];
  
  //Sorting
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"item" ascending:YES];
  fetchRequest.sortDescriptors = @[sortDescriptor];
  
  //Filterting
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@",fieldName,user.username];
  fetchRequest.predicate = predicate;
  
  
  NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                             managedObjectContext:self.managedObjectContext
                                                                                               sectionNameKeyPath:nil
                                                                                                        cacheName:nil];
  [fetchedResultsController performFetch:&error];
  
  return fetchedResultsController;
}
-(void)addToDo:(ToDo *)todo toUser:(User *)user{
  todo.user = user;
  
  [self saveContext];
  
}

@end
