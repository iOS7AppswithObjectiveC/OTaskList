//
//  GMTask.m
//  OTaskList
//
//  Created by ED on 5/1/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMTask.h"

@implementation GMTask

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self){
        self.title = data[TASK_TITLE];
        self.description = data[TASK_DESCRIPTION];
        self.date = data[TASK_DATE];
        self.isCompleted = [data[TASK_COMPLETION] boolValue];
    }
    
    return self;
}

-(id)init
{
    self = [self initWithData:nil];
    
    return self;
}

@end
