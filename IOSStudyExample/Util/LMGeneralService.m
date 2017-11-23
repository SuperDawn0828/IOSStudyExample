//
//  LMGeneralService.m
//  IOSStudyExample
//
//  Created by 黎明 on 2017/8/9.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "LMGeneralService.h"
#import "LMWeakObject.h"

@interface LMGeneralService ()

@property (nonatomic, strong) NSMutableArray *delegates;

@end

@implementation LMGeneralService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegates = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)registerDelegate:(id<LMServiceDelegate>)delegate
{
    if ([delegate conformsToProtocol:@protocol(LMServiceDelegate)]) {
        [self.delegates addObject:[[LMWeakObject alloc] initWithObject: delegate]];
    }
}

- (void)deregisterDelegate:(id<LMServiceDelegate>)delegate
{
    if ([delegate conformsToProtocol:@protocol(LMServiceDelegate)]) {
        [self.delegates addObject:[[LMWeakObject alloc] initWithObject:delegate]];
    }
}

@end
