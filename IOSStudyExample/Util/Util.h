//
//  Util.h
//  IOSStudyExample
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Util : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color frame:(CGRect)frame;

+ (NSString *)getCurrentDateTimeWithFormat:(NSString *)format;

+ (NSTimeInterval)getCurrnentDateTimeInterval;

+ (NSString *)getDateTimeWithInterval:(NSTimeInterval)interval format:(NSString *)format;

+ (NSTimeInterval)getDateTimeIntervalWithDate:(NSString *)dateStr format:(NSString *)format;

@end
