//
//  ScanView.m
//  IOSStudyExample
//
//  Created by 黎明 on 16/10/10.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "ScanView.h"

//扫面内容x的系数
#define SCAN_Y 0.24
//扫面内容y的系数
#define SCAN_X 0.15

@interface ScanView ()
{
    BOOL _on;
}
@property (nonatomic,strong) UIView *scanContentView;
@property (nonatomic,strong) UIImageView *scanLineImageView;

@end

//扫描动画线的高度
static CGFloat const scanLine_Height = 12.0;
static NSString *SCANLINE_ANIMATION = @"scanline_animation";

@implementation ScanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _on = NO;
        self.backgroundColor = [UIColor clearColor];
        [self setupScaningViews];
    }
    return self;
}

- (void)setupScaningViews
{
    CGFloat scanContent_X = self.frame.size.width * SCAN_X;
    CGFloat scanContent_Y = self.frame.size.height * SCAN_Y;
    CGFloat scanContent_W = self.frame.size.width - 2 * scanContent_X;
    CGFloat scanContent_H =self.frame.size.width - 2 * scanContent_X;
    
    self.scanContentView = [[UIView alloc] init];
    self.scanContentView.frame = CGRectMake(scanContent_X, scanContent_Y, scanContent_W, scanContent_H);
    self.scanContentView.layer.borderWidth = 1.0;
    self.scanContentView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6].CGColor;
    self.scanContentView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.scanContentView];
    
    UIImage *tBorderLeftImage = [UIImage imageNamed:@"QRCodeTopLeft"];
    UIImageView *tBorderLeftImageView = [[UIImageView alloc] init];
    tBorderLeftImageView.frame = CGRectMake(0, 0, tBorderLeftImage.size.width, tBorderLeftImage.size.height);
    tBorderLeftImageView.image = tBorderLeftImage;
    [self.scanContentView addSubview:tBorderLeftImageView];
    
    UIImage *tBorderRightImage = [UIImage imageNamed:@"QRCodeTopRight"];
    UIImageView *tBorderRightImageView = [[UIImageView alloc] init];
    tBorderRightImageView.frame = CGRectMake(scanContent_W - tBorderRightImage.size.width, 0, tBorderRightImage.size.width, tBorderRightImage.size.height);
    tBorderRightImageView.image = tBorderRightImage;
    [self.scanContentView addSubview:tBorderRightImageView];
    
    UIImage *bBorderLeftImage = [UIImage imageNamed:@"QRCodebottomLeft"];
    UIImageView *bBorderLeftImageView = [[UIImageView alloc] init];
    bBorderLeftImageView.frame = CGRectMake(0, scanContent_H - bBorderLeftImage.size.height, bBorderLeftImage.size.width, bBorderLeftImage.size.height);
    bBorderLeftImageView.image = bBorderLeftImage;
    [self.scanContentView addSubview:bBorderLeftImageView];
    
    UIImage *bBorderRightImage = [UIImage imageNamed:@"QRCodebottomRight"];
    UIImageView *bBorderRightImageView = [[UIImageView alloc] init];
    bBorderRightImageView.frame = CGRectMake(scanContent_W - bBorderRightImage.size.width, scanContent_H - bBorderLeftImage.size.height, bBorderRightImage.size.width, bBorderRightImage.size.height);
    bBorderRightImageView.image = bBorderRightImage;
    [self.scanContentView addSubview:bBorderRightImageView];
    
    self.scanLineImageView = [[UIImageView alloc] init];
    self.scanLineImageView.image = [UIImage imageNamed:@"QRCodeLine"];
    self.scanLineImageView.frame = CGRectMake(0, 0, scanContent_W, scanLine_Height);
    [self.scanContentView addSubview:self.scanLineImageView];
    
    UIView *topMaskView = [[UIView alloc] init];
    topMaskView.frame = CGRectMake(0, 0, self.frame.size.width, scanContent_Y);
    topMaskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:topMaskView];
    
    UIView *leftMaskView = [[UIView alloc] init];
    leftMaskView.frame = CGRectMake(0, scanContent_Y, scanContent_X, scanContent_H);
    leftMaskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:leftMaskView];
    
    UIView *rightMaskView = [[UIView alloc] init];
    rightMaskView.frame = CGRectMake(scanContent_X + scanContent_W, scanContent_Y,scanContent_X, scanContent_H);
    rightMaskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:rightMaskView];
    
    UIView *bottomMaskView = [[UIView alloc] init];
    bottomMaskView.frame = CGRectMake(0, scanContent_Y + scanContent_H, self.frame.size.width, self.frame.size.height - ( scanContent_Y + scanContent_H));
    bottomMaskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:bottomMaskView];
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clickButton.frame = CGRectMake(scanContent_X, scanContent_H + scanContent_Y + 20, scanContent_W, 50);
    [clickButton setTitle:@"打开照明灯" forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clickButton];
}

- (void)createScanLineAnimation
{
    CGFloat pointStart_X = (self.frame.size.width * (1 - 2 * SCAN_X))/2.0;
    CGFloat pointEnd_X = (self.frame.size.width * (1 - 2 * SCAN_X))/2.0;
    CGFloat pointStart_Y = scanLine_Height/2.0;
    CGFloat pointEnd_Y = self.frame.size.width * (1 - 2 * SCAN_X) - scanLine_Height/2.0;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(pointStart_X, pointStart_Y)];
    [path addLineToPoint:CGPointMake(pointEnd_X, pointEnd_Y)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.duration = 3.0;
    animation.autoreverses = NO;
    animation.repeatCount = MAXFLOAT;
    [self.scanLineImageView.layer addAnimation:animation forKey:SCANLINE_ANIMATION];
}

- (void)clickButtonAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scanView:clickAciton:)]) {
        _on = !_on;
        [self.delegate scanView:self clickAciton:_on];
    }
}


@end
