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

@interface ToDoTableViewController ()<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ToDoTableViewController
- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    self.isEditingAllowed = YES;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self prepareView];
  [self prepareData];
}
-(void)prepareView{
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  UISwipeGestureRecognizer *swipToComplete = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(swipeToComplete:)]
  ;
  swipToComplete.direction = UISwipeGestureRecognizerDirectionRight;
  [self.tableView addGestureRecognizer:swipToComplete];
  
  //Check if allow editing
  if (self.isEditingAllowed){
    //Edit button
    self.navigationItem.leftBarButtonItem  = self.editButtonItem;
    self.editButtonItem.target = self;
    self.editButtonItem.action = @selector(editTapped);
    //Add button
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButton)];
  }
  
  [self.navigationController.navigationBar setBackgroundColor:[UIColor yellowColor]];
}
-(void)prepareData{
  //Get current user
  if (!self.currentUser){
    self.currentUser = [[CoreDataHandler sharedInstance] getUserWithUsername:@"karlop"];
  }
  //Set the fetchedResultsController
  self.fetchedResultsController = [[CoreDataHandler sharedInstance] getAllToDoForUser:self.currentUser];
  self.fetchedResultsController.delegate = self;
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
  if ([toDo.status isEqualToString:@"Complete"]) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  }
  
  return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
  return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    [[CoreDataHandler sharedInstance] deleteToDo:[self.fetchedResultsController objectAtIndexPath:indexPath]];
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

//MARK: NSFetchedResultsControllerDelegate
-(void)controller:(NSFetchedResultsController *)controller
  didChangeObject:(id)anObject
      atIndexPath:(NSIndexPath *)indexPath
    forChangeType:(NSFetchedResultsChangeType)type
     newIndexPath:(NSIndexPath *)newIndexPath{
  UITableView *tableView = self.tableView;
  
  switch(type) {
    case NSFetchedResultsChangeInsert:
      [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeDelete:
      [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeUpdate:
//      [[self.tableView cellForRowAtIndexPath:indexPath] setItem:anObject];
      break;
    case NSFetchedResultsChangeMove:
      [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
      break;
  }
  
  [self.tableView reloadData];
}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
  [self.tableView beginUpdates];
}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
  [self.tableView endUpdates];
}

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
-(void)addButton{
  [self performSegueWithIdentifier:@"showAddToDo" sender:self];
}
-(void)completeItem:(NSIndexPath *)indexpath{
  ToDo *toDoToComplete = [self.fetchedResultsController objectAtIndexPath:indexpath];
  toDoToComplete.status = @"Complete";
  [[CoreDataHandler sharedInstance] updateToDo:toDoToComplete];
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
//MARK: Gestures
-(void)swipeToComplete:(UISwipeGestureRecognizer *)recognizer{
  NSLog(@"swipe registered");
  
  CGPoint location = [recognizer locationInView:self.tableView];
  NSIndexPath *indexSwiped = [self.tableView indexPathForRowAtPoint:location];
  if(indexSwiped.section != 1){
    [self completeItem:indexSwiped];
  }
  NSLog(@"%@",indexSwiped);
}
@end

