//
//  AddToDoViewController.m
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "AddToDoViewController.h"
#import "User.h"
#import "ToDo.h"
#import "CoreDataHandler.h"

@interface AddToDoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *toDoItemTextField;
@property (strong, nonatomic) IBOutlet UITextField *toDoPriorityTextField;
@property (strong, nonatomic) IBOutlet UITextField *toDoDescriptionTextField;
@property (strong, nonatomic) IBOutlet UITextField *toDoUserTextField;
@property (strong, nonatomic) IBOutlet UITextField *toDoStatusTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *toDodatePicker;
@end

@implementation AddToDoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self prepareView];
  [self getDefaultToDo];
}
-(void)prepareView{
  self.toDoUserTextField.text = self.currentUser.name;
  self.toDoUserTextField.enabled = NO;
}
- (IBAction)saveToDo:(id)sender {
  ToDo *toDo = [NSEntityDescription insertNewObjectForEntityForName:@"ToDo"
                                             inManagedObjectContext:[CoreDataHandler sharedInstance].managedObjectContext ];
  toDo.item = self.toDoItemTextField.text;
  toDo.priority = self.toDoPriorityTextField.text;
  toDo.detailedDescription = self.toDoDescriptionTextField.text;
  toDo.user.name = self.toDoUserTextField.text;
  toDo.status = self.toDoStatusTextField.text;
  //  self.toDo.deadline = self.toDoDeadlineTextField.text;
  
  [[CoreDataHandler sharedInstance] addToDo:toDo toUser:self.currentUser];
  [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelButton:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)getDefaultToDo{
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  NSString *defaultItem = [userDefault stringForKey:@"defaultItem"];
  if (defaultItem != nil){
    self.toDoItemTextField.text = defaultItem;
  }
}
@end
