//
//  TableViewController.m
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "CoreData/CoreData.h"
#import "CoreDataHandler.h"
#import "User.h"
#import "ToDo.h"
#import "AddToDoViewController.h"
#import "ToDoDetailViewController.h"

@interface ToDoTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ToDoTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self prepareView];
  [self prepareData];
}
-(void)viewDidAppear:(BOOL)animated{
  self.fetchedResultsController = [[CoreDataHandler sharedInstance] getAllToDoForUser:self.currentUser];
  [self.tableView reloadData];
}
-(void)prepareView{
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  //Edit button
  self.navigationItem.leftBarButtonItem  = self.editButtonItem;
  self.editButtonItem.target = self;
  self.editButtonItem.action = @selector(editTapped);
  
}
-(void)prepareData{
  //Get current user
  if (!self.currentUser){
    self.currentUser = [[CoreDataHandler sharedInstance] getUserWithUsername:@"karlop"];
  }
  if (self.currentUser.toDo.count == 0){
    ToDo *toDo = [NSEntityDescription insertNewObjectForEntityForName:@"ToDo" inManagedObjectContext:[CoreDataHandler sharedInstance].managedObjectContext];
    toDo.item = @"Test task";
    
    [[CoreDataHandler sharedInstance] addToDo:toDo toUser:self.currentUser];
  }
  
  self.fetchedResultsController = [[CoreDataHandler sharedInstance] getAllToDoForUser:self.currentUser];
}

//MARK: Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.fetchedResultsController.sections[section].numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toDoCell" forIndexPath:indexPath];
  
  // Configure the cell...
  ToDo *toDo = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = toDo.item;
  cell.detailTextLabel.text = @"detail text label";
  
  return cell;
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  // Return NO if you do not want the specified item to be editable.
  return YES;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
}

// // Override to support rearranging the table view.
// - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
// }
//
// // Override to support conditional rearranging of the table view.
// - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
// // Return NO if you do not want the item to be re-orderable.
// return YES;
// }

//MARK: Actions
-(void)editTapped{
  [self.tableView setEditing:!self.tableView.editing animated:YES];
  //Toggle Edit/Done button
  if (self.tableView.editing) {
    [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
  } else{
    [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
  }
}

//MARK: Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  if ([segue.identifier isEqualToString:@"showAddToDo"]) {
    AddToDoViewController *destinationVC = segue.destinationViewController;
    destinationVC.currentUser = self.currentUser;
  } else if ([segue.identifier isEqualToString:@"showDetailToDo"]) {
    ToDoDetailViewController *destinationVC = segue.destinationViewController;
    destinationVC.toDo = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];;
  }
  
}
@end

