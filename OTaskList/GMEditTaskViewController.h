//
//  GMEditTaskViewController.h
//  OTaskList
//
//  Created by ED on 5/1/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMEditTaskViewController : UIViewController
- (IBAction)editSaveBarButtonPressed:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextView *editTextView;
@property (strong, nonatomic) IBOutlet UITextField *editTaskNameTextfield;

@end
