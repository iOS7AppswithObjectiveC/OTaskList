//
//  GMViewController.h
//  OTaskList
//
//  Created by ED on 5/1/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMViewController : UIViewController
- (IBAction)reorderBarButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)adTaskBarButtonPressed:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableViewMain;

@end
