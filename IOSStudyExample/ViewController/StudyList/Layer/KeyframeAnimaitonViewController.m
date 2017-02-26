//
//  KeyframeAnimaitonViewController.m
//  IOSStudyExample
//
//  Created by 黎明 on 16/9/12.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "KeyframeAnimaitonViewController.h"

static NSString *kAnimtion = @"KeyAnimation";

@interface KeyframeAnimaitonViewController ()
@property (nonatomic,strong) UIButton *heartButton;
@property (nonatomic,strong) UIButton *cornerButton;
@property (nonatomic,strong) CALayer *cornerLayer;

@end

@implementation KeyframeAnimaitonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupButton];
    [self setupLayer];
}

- (void)setupButton
{
    self.heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.heartButton setBackgroundImage:[UIImage imageNamed:@"icon_rent_heart"] forState:UIControlStateNormal];
    [self.heartButton setBackgroundImage:[UIImage imageNamed:@"icon_rent_redheart"] forState:UIControlStateSelected];
    [self.heartButton addTarget:self action:@selector(heartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.heartButton];
    [self.heartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(SizeOfFloat(100));
        make.top.mas_equalTo(self.view.mas_top).offset(SizeOfFloat(100));
    }];
    
    self.cornerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cornerButton setBackgroundColor:[UIColor redColor]];
    [self.cornerButton addTarget:self action:@selector(cornerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cornerButton];
    [self.cornerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(SizeOfFloat(300));
        make.top.mas_equalTo(self.view.mas_top).offset(SizeOfFloat(100));
        make.size.mas_equalTo(CGSizeMake(SizeOfFloat(50), SizeOfFloat(50)));
    }];
}

- (void)setupLayer
{
    self.cornerLayer = [[CALayer alloc] init];
    self.cornerLayer.position = CGPointMake(SizeOfFloat(100), SizeOfFloat(300));
    self.cornerLayer.bounds = CGRectMake(0, 0, SizeOfFloat(100), SizeOfFloat(100));
    self.cornerLayer.backgroundColor = [UIColor yellowColor].CGColor;
    self.cornerLayer.cornerRadius = SizeOfFloat(50);
    self.cornerLayer.masksToBounds = YES;
    [self.view.layer addSublayer:self.cornerLayer];
}

- (void)heartButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [sender.layer removeAnimationForKey:kAnimtion];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:0];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.4, 1.4, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.6, 1.6, 1.0)]];
    [animation setValues:values];
    [animation setRepeatCount:1.0];
    [animation setAutoreverses:YES];
    [animation setDuration:0.15];
    [sender.layer addAnimation:animation forKey:kAnimtion];
}

- (void)cornerButtonClick:(UIButton *)sender
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(SizeOfFloat(100), SizeOfFloat(300))];
    [path addQuadCurveToPoint:CGPointMake(SizeOfFloat(650), SizeOfFloat(300)) controlPoint:CGPointMake(SizeOfFloat(450), SizeOfFloat(100))];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.duration = 3;
//    animation.autoreverses = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.cornerLayer addAnimation:animation forKey:nil];
}

@end
