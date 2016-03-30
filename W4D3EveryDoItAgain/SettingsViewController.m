//
//  SettingsViewController.m
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *toDoItemTextField;
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self prepareView];
  [self prepareUserDefaults];
  
}
-(void)prepareView{
  [self.navigationBar setBackgroundColor:[UIColor blueColor]];
}
-(void)prepareUserDefaults{
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  NSString *defaultItem = [userDefault stringForKey:@"defaultItem"];
  if (defaultItem != nil){
    self.toDoItemTextField.text = defaultItem;
  }
}
- (IBAction)saveButton:(id)sender {
  
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  [userDefault setObject:self.toDoItemTextField.text forKey:@"defaultItem"];
  
  //Alert -successful
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved" message:@"Settings was successfully saved." preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
  
  [self presentViewController:alert animated:YES completion:nil];
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
