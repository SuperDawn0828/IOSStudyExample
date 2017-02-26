//
//  GCDTimer.m
//  IOSStudyExample
//
//  Created by mac on 16/9/2.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "GCDTimer.h"

@interface GCDTimer ()
@property (nonatomic,strong) dispatch_source_t gcdTimer;

@end

@implementation GCDTimer

+ (GCDTimer *)timerWithInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay timerEventHeader:(void(^)(void))eventHeader
{
    GCDTimer *timer = [[GCDTimer alloc] init];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer.gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay*NSEC_PER_SEC));
    dispatch_source_set_timer(timer.gcdTimer, delayTime, (int64_t)(interval*NSEC_PER_SEC), 0);
    dispatch_source_set_event_handler(timer.gcdTimer, eventHeader);
    return timer;
}

- (void)timerStart
{
    if (self.gcdTimer) {
        dispatch_resume(_gcdTimer);
    }
}

- (void)timerStop
{
    if (self.gcdTimer) {
        dispatch_cancel(self.gcdTimer);
        self.gcdTimer = nil;
    }
}

- (void)dealloc
{
    [self timerStop];
}

@end
