//
//  ToDoDetailViewController.m
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ToDoDetailViewController.h"
#import "ToDo.h"

@interface ToDoDetailViewController ()
@property (strong, nonatomic) IBOutlet UITextField *toDoItemTextField;

@end

@implementation ToDoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  self.toDoItemTextField.text = self.toDo.item;
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
