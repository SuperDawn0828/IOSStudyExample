//
//  LMPlayerProtocol.h
//  IOSStudyExample
//
//  Created by 黎明 on 2017/8/9.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LMPlayerProtocol <NSObject>

@property (nonatomic, strong) NSURL *url;

- (BOOL)start;

- (void)stop;

@end
