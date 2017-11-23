//
//  LMWeakObject.h
//  IOSStudyExample
//
//  Created by 黎明 on 2017/8/9.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMWeakObject : NSObject

@property (nonatomic, weak, readonly) id object;

+ (instancetype)weakObjectWithObject:(id)object;

- (instancetype)initWithObject:(id)object;

@end
