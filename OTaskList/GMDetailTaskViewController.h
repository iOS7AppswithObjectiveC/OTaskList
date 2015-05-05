//
//  GMDetailTaskViewController.h
//  OTaskList
//
//  Created by ED on 5/1/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMTask.h"
#import "GMEditTaskViewController.h"

@protocol GMDetailTaskViewControllerDelegate <NSObject>

-(void)updateTask;

@end

@interface GMDetailTaskViewController : UIViewController <GMEditTaskViewControllerDelegate>

@property (strong, nonatomic) GMTask *task;

@property (weak, nonatomic) id <GMDetailTaskViewControllerDelegate> delegate;

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDetailsLabel;

@end
