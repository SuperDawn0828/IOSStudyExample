//
//  LMGeneralService.h
//  IOSStudyExample
//
//  Created by 黎明 on 2017/8/9.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LMGeneralService;

@protocol LMServiceDelegate <NSObject>

@optional
- (void)generalservice:(LMGeneralService *)service didRetrieveEntries:(NSArray *)entries;

@end

@interface LMGeneralService : NSObject

- (void)registerDelegate:(id<LMServiceDelegate>)delegate;

- (void)deregisterDelegate:(id<LMServiceDelegate>)delegate;

@end
