//
//  NSObject+Encode.h
//  IOSStudyExample
//
//  Created by 黎明 on 2017/3/2.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Encode)

- (instancetype)LM_initWithCoder:(NSCoder *)aDecoder;
- (void)LM_encodeWithCoder:(NSCoder *)aCoder;

@end
