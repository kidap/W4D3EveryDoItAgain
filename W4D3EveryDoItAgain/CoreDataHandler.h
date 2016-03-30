//
//  CoreDataHandler.h
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObjectContext;
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@class NSFetchedResultsController;
@class User;
@class ToDo;

@interface CoreDataHandler : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(instancetype)sharedInstance;
-(void)saveContext;
-(NSURL *)applicationDocumentsDirectory;
-(NSFetchedResultsController *)getAllUsers;
-(User *)getUserWithUsername:(NSString *)username;
-(NSFetchedResultsController *)getAllToDoForUser:(User *)user;
-(void)addToDo:(ToDo *)todo toUser:(User *)user;
-(void)deleteToDo:(ToDo *)todo;
-(void)updateToDo:(ToDo *)todo;
@end
