//
//  ColorHelper.m
//  IOSStudyExample
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "ColorHelper.h"

static const int BackgroundColor = 0xf2f3f4;
static const int LineColor = 0xdddddd;
static const int TitleColor = 0x222222;
static const int MainColor = 0x3bd2c9;

@implementation ColorHelper

+ (UIColor *)colorForBackground
{
    return UIColorFromRGB(BackgroundColor);
}

+ (UIColor *)colorForLine
{
    return UIColorFromRGB(LineColor);
}

+ (UIColor *)colorForTitle
{
    return UIColorFromRGB(TitleColor);
}

+ (UIColor *)colorForMain
{
    return UIColorFromRGB(MainColor);
}

@end
