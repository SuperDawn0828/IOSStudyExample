//
//  BaseViewController.m
//  IOSStudyExample
//
//  Created by mac on 16/8/31.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"navigationDeleage: %@", self.navigationController.interactivePopGestureRecognizer.delegate);
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIFont *font = [UIFont systemFontOfSize:18];
    UIColor *color = [UIColor blackColor];
    NSDictionary *attr = @{NSFontAttributeName:font,
                                NSForegroundColorAttributeName:color};
    [self.navigationController.navigationBar setTitleTextAttributes:attr];
    
    if ((self.navigationController && self.navigationController.viewControllers.firstObject != self) || self.navigationController.presentingViewController) {
        UIImage *image = [[UIImage imageNamed:@"bar_back_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(leftClickBlack)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view setBackgroundColor:[ColorHelper colorForBackground]];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)leftClickBlack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
