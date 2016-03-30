//
//  TableViewController.h
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NSFetchedResultsController;
@class User;

@interface ToDoTableViewController : UIViewController
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) User *currentUser;
@end
