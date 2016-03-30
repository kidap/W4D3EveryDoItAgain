//
//  ToDoDetailViewController.m
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ToDoDetailViewController.h"
#import "ToDo.h"
#import "User.h"

@interface ToDoDetailViewController ()
@property (strong, nonatomic) IBOutlet UITextField *toDoItemTextField;
@property (strong, nonatomic) IBOutlet UITextField *toDoPriorityTextField;
@property (strong, nonatomic) IBOutlet UITextField *toDoDescriptionTextField;
@property (strong, nonatomic) IBOutlet UITextField *toDoUserTextField;
@property (strong, nonatomic) IBOutlet UITextField *toDoStatusTextField;
@property (strong, nonatomic) IBOutlet UITextField *toDoDeadlineTextField;

@end

@implementation ToDoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  self.toDoItemTextField.text = self.toDo.item;
  self.toDoPriorityTextField.text = self.toDo.priority;
  self.toDoDescriptionTextField.text = self.toDo.detailedDescription;
  self.toDoUserTextField.text = self.toDo.user.name;
  self.toDoStatusTextField.text = self.toDo.status;
  //  self.toDoDeadlineTextField.text = self.toDo.deadline
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
