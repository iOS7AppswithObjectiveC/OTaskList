//
//  GMEditTaskViewController.h
//  OTaskList
//
//  Created by ED on 5/1/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMTask.h"

@protocol GMEditTaskViewControllerDelegate <NSObject>

-(void)didUpdateTask;

@end

@interface GMEditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) GMTask *task;
@property (weak, nonatomic) id <GMEditTaskViewControllerDelegate> delegate;


- (IBAction)editSaveBarButtonPressed:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextView *editTextView;
@property (strong, nonatomic) IBOutlet UITextField *editTaskNameTextfield;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickerEdit;

@end
