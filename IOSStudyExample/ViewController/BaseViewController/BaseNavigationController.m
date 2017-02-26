//
//  BaseNavigationContrlooer.m
//  IOSStudyExample
//
//  Created by 黎明 on 16/9/8.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        //实现导航控制器左侧滑返回
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = YES;
        
        //实现导航控制器全屏侧滑返回
        //id target = self.interactivePopGestureRecognizer.delegate;
        //SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
        //UIView *targerView = self.interactivePopGestureRecognizer.view;
        //UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handler];
        //pan.delegate = self;
        //[targerView addGestureRecognizer:pan];
        //self.interactivePopGestureRecognizer.enabled = NO;
        
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //实现导航控制器左侧滑返回
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return self.viewControllers.count > 1;
    }
    return YES;
    //return self.viewControllers.count > 1;
}

@end
