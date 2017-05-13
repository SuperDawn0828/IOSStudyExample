//
//  ScanQRAlertView.h
//  IOSStudyExample
//
//  Created by 黎明 on 2017/4/1.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanQRAlertView : UIView

+ (instancetype)scanQRAlertDetail:(NSString *)detail actionHandlers:(NSArray *)handlers;

- (void)show;

@end

typedef void (^ActionHandler)(NSString *string);
@interface ScanQRAlertAction : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,copy) ActionHandler handler;

+ (instancetype)actionWithTitle:(NSString *)title actionHandler:(ActionHandler)handler;

@end
