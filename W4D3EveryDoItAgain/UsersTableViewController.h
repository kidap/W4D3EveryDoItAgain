//
//  UsersTableViewController.h
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NSFetchedResultsController;

@interface UsersTableViewController : UITableViewController
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end
