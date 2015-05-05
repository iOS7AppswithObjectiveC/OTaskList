//
//  GMDetailTaskViewController.m
//  OTaskList
//
//  Created by ED on 5/1/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMDetailTaskViewController.h"

@interface GMDetailTaskViewController ()
@end

@implementation GMDetailTaskViewController

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
    
    self.taskNameLabel.text = self.task.title;
    self.taskDetailsLabel.text = self.task.description;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    
    self.dateLabel.text = stringFromDate;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[GMEditTaskViewController class]]){
        GMEditTaskViewController *editTaskViewController = segue.destinationViewController;
        editTaskViewController.task = self.task;
        editTaskViewController.delegate = self;
    }}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender {
}

#pragma mark GMEditTaskViewControllerDelegate

-(void)didUpdateTask
{
    
    self.taskNameLabel.text = self.task.title;
    self.taskDetailsLabel.text = self.task.description;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    self.dateLabel.text = stringFromDate;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate updateTask];
}
@end
