//
//  Macros.h
//  IOSStudyExample
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 黎明. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define SCREEN_FRAME ([UIScreen mainScreen].applicationFrame)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define NAVIGATIONBAR_HEIGHT 44
#define STATUSBAR_HEIGHT 20
#define NAVIGATION_STATUS_HEIGHT 64

#define UIColorFromRGB(value) ([UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0x00FF00) >> 8))/255.0 blue:((float)((value & 0x0000FF)))/255.0 alpha:1])

#define SCALE (SCREEN_WIDTH == 320?(1.0):(SCREEN_WIDTH == 414?((414 - 375)/375.0 + 1):(1.0)))
#define SECOUND_SCALE (SCREEN_WIDTH == 320?(1 - (375 - 320)/375.0):(SCREEN_WIDTH == 414)?((414 - 375)/375.0 + 1):(1.0))

#define SizeOfFloat(a) ((a/2.0)*SCALE)
#define SizeOfFlaot_SECOUND(a) ((a/2.0)*SECOUND_SCALE)


#endif /* Macros_h */
