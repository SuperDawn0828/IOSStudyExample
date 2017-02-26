//
//  Util.m
//  IOSStudyExample
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (UIImage *)imageWithColor:(UIColor *)color frame:(CGRect)frame
{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString *)getCurrentDateTimeWithFormat:(NSString *)format
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString *time = [formatter stringFromDate:date];
    return time;
    
}

+ (NSTimeInterval)getCurrnentDateTimeInterval
{
    NSDate *date = [NSDate date];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return timeInterval;
}

+ (NSString *)getDateTimeWithInterval:(NSTimeInterval)interval format:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString *time = [formatter stringFromDate:date];
    return time;
}

+ (NSTimeInterval)getDateTimeIntervalWithDate:(NSString *)dateStr format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:dateStr];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return timeInterval;
}

@end
