//
//  GMEditTaskViewController.m
//  OTaskList
//
//  Created by ED on 5/1/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMEditTaskViewController.h"

@interface GMEditTaskViewController ()

@end

@implementation GMEditTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.editTaskNameTextfield.text = self.task.title;
    self.editTextView.text = self.task.description;
    self.datePickerEdit.date = self.task.date;
    
    self.editTextView.delegate = self;
    self.editTaskNameTextfield.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editSaveBarButtonPressed:(UIBarButtonItem *)sender {
    
    [self updateTask];
    [self.delegate didUpdateTask];
}

-(void)updateTask
{
    self.task.title = self.editTaskNameTextfield.text;
    self.task.description = self.editTextView.text;
    self.task.date = self.datePickerEdit.date;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.editTaskNameTextfield resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        [self.editTextView resignFirstResponder];
        return NO;
    }
    else return YES;
}
@end
