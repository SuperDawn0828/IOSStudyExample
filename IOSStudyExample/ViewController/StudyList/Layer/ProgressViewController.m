//
//  ProgressViewController.m
//  IOSStudyExample
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "ProgressViewController.h"
#import "ProgressView.h"

@interface ProgressViewController ()
@property (nonatomic,strong) ProgressView *progressView;
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation ProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"ProgressView";
    
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(SizeOfFloat(30), SizeOfFloat(200), SCREEN_WIDTH - SizeOfFloat(60), SizeOfFloat(20))];
    [self.slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.slider];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(SizeOfFloat(30), SizeOfFloat(300), SCREEN_WIDTH - SizeOfFloat(60), SizeOfFloat(20))];
    self.lineView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.lineView];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.position = CGPointMake((SCREEN_WIDTH - SizeOfFloat(60))/2.0, SizeOfFloat(10));
    shapeLayer.bounds = CGRectMake(0, 0, SCREEN_WIDTH - SizeOfFloat(60), SizeOfFloat(20));
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = SizeOfFloat(1);
    shapeLayer.lineDashPattern = @[@(5),@(2.5)];
    [self.lineView.layer addSublayer:shapeLayer];
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, SizeOfFloat(10))];
    [linePath addLineToPoint:CGPointMake(SCREEN_WIDTH - SizeOfFloat(60), SizeOfFloat(10))];
    shapeLayer.path = linePath.CGPath;
    
    self.progressView = [[ProgressView alloc]init];
    self.progressView.center = self.view.center;
    self.progressView.bounds = CGRectMake(0, 0, SizeOfFloat(200), SizeOfFloat(200));
    self.progressView.backgroundColor = [UIColor whiteColor];
    self.progressView.tintColor = [ColorHelper colorForLine];
    self.progressView.progressColor = [ColorHelper colorForMain];
    self.progressView.lineWidth = SizeOfFloat(1);
    [self.view addSubview:self.progressView];
}

- (void)sliderValueChange:(UISlider *)sender
{
    NSLog(@"%.2f",sender.value);
    [self.progressView setProgressValue:sender.value animated:YES];
}


@end
