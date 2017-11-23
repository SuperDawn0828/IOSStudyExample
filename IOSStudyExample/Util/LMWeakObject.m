//
//  LMWeakObject.m
//  IOSStudyExample
//
//  Created by 黎明 on 2017/8/9.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "LMWeakObject.h"

@interface LMWeakObject ()

@property (nonatomic, weak) id object;

@end

@implementation LMWeakObject

+ (instancetype)weakObjectWithObject:(id)object
{
    return [[LMWeakObject alloc] initWithObject:object];
}

- (instancetype)initWithObject:(id)object
{
    self = [super init];
    if (self) {
        self.object = object;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[object class]]) {
        return NO;
    }
    
    return [self isEqualToWeakObject:(LMWeakObject *)object];
}

- (BOOL)isEqualToWeakObject:(LMWeakObject *)object
{
    if (!object) {
        return NO;
    }
    
    BOOL objectsMatch = [self.object isEqual:object.object];
    return objectsMatch;
}

- (NSUInteger)hash
{
    return [self.object hash];
}

@end
