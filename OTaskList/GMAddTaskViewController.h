//
//  GMAddTaskViewController.h
//  OTaskList
//
//  Created by ED on 5/1/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMTask.h"

@protocol GMAddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask:(GMTask *)task;

@end

@interface GMAddTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id <GMAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;


- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
