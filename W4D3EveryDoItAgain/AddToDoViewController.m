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
@end

@implementation AddToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)saveToDo:(id)sender {
  ToDo *toDo = [NSEntityDescription insertNewObjectForEntityForName:@"ToDo"
                                              inManagedObjectContext:[CoreDataHandler sharedInstance].managedObjectContext ];
  toDo.item = self.toDoItemTextField.text;
  
  [[CoreDataHandler sharedInstance] addToDo:toDo toUser:self.currentUser];
  [self dismissViewControllerAnimated:YES completion:nil];
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
