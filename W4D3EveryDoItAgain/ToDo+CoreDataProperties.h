//
//  ToDo+CoreDataProperties.h
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *item;
@property (nullable, nonatomic, retain) NSString *priority;
@property (nonatomic) NSTimeInterval deadline;
@property (nullable, nonatomic, retain) NSString *detailedDescription;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
