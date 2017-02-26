//
//  GCDTimer.h
//  IOSStudyExample
//
//  Created by mac on 16/9/2.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDTimer : NSObject

+ (GCDTimer *)timerWithInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay timerEventHeader:(void(^)(void))eventHeader;

- (void)timerStart;

- (void)timerStop;

@end
