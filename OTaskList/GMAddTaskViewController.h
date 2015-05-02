//
//  GMAddTaskViewController.h
//  OTaskList
//
//  Created by ED on 5/1/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMAddTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *addTaskTextView;
@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
