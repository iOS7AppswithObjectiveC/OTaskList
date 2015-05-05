//
//  GMViewController.m
//  OTaskList
//
//  Created by ED on 5/1/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMViewController.h"


@interface GMViewController ()

@end

@implementation GMViewController

-(NSMutableArray *)taskObjects
{
    if (!_taskObjects){
        _taskObjects = [[NSMutableArray alloc] init];
    }
    
    return _taskObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY];
    
    for (NSDictionary *dictionary in tasksAsPropertyLists){
        GMTask *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObjects addObject:taskObject];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[GMAddTaskViewController class]]){
        GMAddTaskViewController *addTaskViewController = segue.destinationViewController;
        addTaskViewController.delegate = self;
    }
    
    else if ([segue.destinationViewController isKindOfClass:[GMDetailTaskViewController class]]){
        GMDetailTaskViewController *detailTaskViewController = segue.destinationViewController;
        NSIndexPath *path = sender;
        GMTask *taskObject = self.taskObjects[path.row];
        detailTaskViewController.task = taskObject;
        detailTaskViewController.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderBarButtonPressed:(UIBarButtonItem *)sender
{
    if (self.tableView.editing == YES)[self.tableView setEditing:NO animated:YES];
    else [self.tableView setEditing:YES animated:YES];
}

- (IBAction)adTaskBarButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"addTaskSegue" sender:nil];
    
}

#pragma mark - GMAddTaskViewControllerDelegate

-(void)didAddTask:(GMTask *)task
{
    [self.taskObjects addObject:task];
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [taskObjectsAsPropertyLists addObject:[self taskObjectAsAPropertyList:task]];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
    
}

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - GMDetailTaskViewControllerDelegate

-(void)updateTask
{
    [self saveTasks];
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

-(NSDictionary *)taskObjectAsAPropertyList:(GMTask *)taskObject
{
    NSDictionary *dictionary = @{TASK_TITLE : taskObject.title,
                                 TASK_DESCRIPTION : taskObject.description,
                                 TASK_DATE : taskObject.date,
                                 TASK_COMPLETION : @(taskObject.isCompleted)
                                 };
    
    return dictionary;
    
}


-(GMTask *)taskObjectForDictionary:(NSDictionary *)dictionary
{
    GMTask *taskObject = [[GMTask alloc] initWithData:dictionary];
    return taskObject;
}

-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if (dateInterval > toDateInterval) return YES;
    else return NO;
}

-(void)updateCompletionOfTask:(GMTask *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if(task.isCompleted == YES) task.isCompleted = NO;
    else task.isCompleted = YES;
    
    [taskObjectsAsPropertyLists insertObject:[self taskObjectAsAPropertyList:task] atIndex:indexPath.row];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

-(void)saveTasks
{
    NSMutableArray *taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.taskObjects count]; x ++){
        [taskObjectsAsPropertyLists addObject:[self taskObjectAsAPropertyList:self.taskObjects[x]]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /* The number of rows should be the number of task's in the taskObjects Array */
    return [self.taskObjects count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    /* We will only have 1 section for now */
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    

    GMTask *task = self.taskObjects[indexPath.row];
    cell.textLabel.text = task.title;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   [formatter setDateFormat:@"yyyy-MM-dd"];
   NSString *stringFromDate = [formatter stringFromDate:task.date];
//    
//    /* Update the detailTextLabel with the date string */
   cell.detailTextLabel.text = stringFromDate;
//    
//    /* Determine if the task is overdue using the helper method isDateGreaterThanDate */
    BOOL isOverDue = [self isDateGreaterThanDate:[NSDate date] and:task.date];
    

   if (task.isCompleted == YES) cell.backgroundColor = [UIColor greenColor];
    else if (isOverDue == YES) cell.backgroundColor = [UIColor redColor];
   else cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate

/* When the user taps a cell in the tableView the task's isCompleted status should update. Use the helper method updateCompletionOfTask. */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMTask *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

/* Allow the user to edit tableViewCells for deletion */
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/* Method called when the users swipes and presses the delete key */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        /* If a user deletes the row remove the task at that row from the tasksArray */
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        /* With the updated array of task objects iterate over them and convert them to plists. Save the plists in the newTaskObjectsData NSMutableArray. Save this array to NSUserDefaults. */
        NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc] init];
        
        for (GMTask *task in self.taskObjects){
            [newTaskObjectsData addObject:[self taskObjectAsAPropertyList:task]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsData forKey:TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        /* Animate the deletion of the cell */
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

/* When the user taps the accessory button transition to the DetailTaskViewController */
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailTaskViewControllerSegue" sender:indexPath];
}

/* Allow the user to move cells in the tableView */
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/* Method called when the user moves a cell while in editing mode */
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    /* Determine which task was moved and update the taskObjects array by remove the object from it's old index and inserting it at it's new index. Save the updated taskObjects array to NSUserDefaults using the helper method saveTasks */
    GMTask *taskObject = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:taskObject atIndex:destinationIndexPath.row];
    //[self saveTasks];
}




@end
