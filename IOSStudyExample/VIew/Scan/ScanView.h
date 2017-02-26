//
//  ScanView.h
//  IOSStudyExample
//
//  Created by 黎明 on 16/10/10.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanViewDelegate;

@interface ScanView : UIView
@property (nonatomic,assign) id <ScanViewDelegate> delegate;

- (void)createScanLineAnimation;

@end

@protocol ScanViewDelegate <NSObject>

@optional
- (void)scanView:(ScanView *)view clickAciton:(BOOL)on;

@end
