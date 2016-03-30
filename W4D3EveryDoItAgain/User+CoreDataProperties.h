//
//  User+CoreDataProperties.h
//  W4D3EveryDoItAgain
//
//  Created by Karlo Pagtakhan on 03/30/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<ToDo *> *toDo;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addToDoObject:(ToDo *)value;
- (void)removeToDoObject:(ToDo *)value;
- (void)addToDo:(NSSet<ToDo *> *)values;
- (void)removeToDo:(NSSet<ToDo *> *)values;

@end

NS_ASSUME_NONNULL_END
