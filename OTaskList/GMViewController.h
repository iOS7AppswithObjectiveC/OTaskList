//
//  GMViewController.h
//  OTaskList
//
//  Created by ED on 5/1/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMAddTaskViewController.h"

#import "GMDetailTaskViewController.h"

@interface GMViewController : UIViewController <GMAddTaskViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, GMDetailTaskViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *taskObjects;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)reorderBarButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)adTaskBarButtonPressed:(UIBarButtonItem *)sender;


@end
