//
//  UsersTableViewController.m
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "UsersTableViewController.h"
#import "ToDoTableViewController.h"
#import "CoreData/CoreData.h"
#import "CoreDataHandler.h"
#import "User.h"

@interface UsersTableViewController ()

@end

@implementation UsersTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self prepareView];
  [self prepareData];
}
-(void)prepareView{
  
}
-(void)prepareData{
  self.fetchedResultsController = [[CoreDataHandler sharedInstance] getAllUsers];
  
  if (self.fetchedResultsController.fetchedObjects.count == 0){
    User *firstUser = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                    inManagedObjectContext:[CoreDataHandler sharedInstance].managedObjectContext];
    firstUser.username = @"karlop";
    firstUser.name = @"Karlo Pagtakhan";
    [[CoreDataHandler sharedInstance] saveContext];
  }
  
  NSLog(@"Data Prep");
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.fetchedResultsController.sections[section].numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
  
  // Configure the cell...
  User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = user.name;
  
  return cell;
}

//MARK: Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  if ([segue.identifier isEqualToString:@"showUserToDo"]) {
    ToDoTableViewController *destinationVC = segue.destinationViewController;
    
  }
}


@end
