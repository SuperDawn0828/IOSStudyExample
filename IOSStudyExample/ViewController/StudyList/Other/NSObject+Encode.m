//
//  NSObject+Encode.m
//  IOSStudyExample
//
//  Created by 黎明 on 2017/3/2.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "NSObject+Encode.h"
#import <objc/runtime.h>

@implementation NSObject (Encode)

- (instancetype)LM_initWithCoder:(NSCoder *)aDecoder
{
    if (!aDecoder) {
        return self;
    }
    
    
    
    if (self == (id)kCFNull) {
        return self;
    }
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [aDecoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
    free(ivars);
    return self;
}

- (void)LM_encodeWithCoder:(NSCoder *)aCoder
{
    if (!aCoder) {
        return;
    }
    
    if (self == (id)kCFNull) {
        [(id<NSCoding>)self encodeWithCoder:aCoder];
        return;
    }
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

@end
