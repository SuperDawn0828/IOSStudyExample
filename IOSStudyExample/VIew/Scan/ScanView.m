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

#define SCALE [UIScreen mainScreen].bounds.size.width/375.0
#define UIColorFromRGB(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

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
    CGFloat scanContent_W = 241*SCALE;
    CGFloat scanContent_H = 241*SCALE;
    CGFloat scanContent_X = (self.frame.size.width - scanContent_W)/2.0;
    CGFloat scanContent_Y = 117*SCALE + 64;
    
    self.scanContentView = [[UIView alloc] init];
    self.scanContentView.frame = CGRectMake(scanContent_X, scanContent_Y, scanContent_W, scanContent_H);
    self.scanContentView.layer.borderWidth = 0.6;
    self.scanContentView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
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
    
//    self.scanLineImageView = [[UIImageView alloc] init];
//    self.scanLineImageView.image = [UIImage imageNamed:@"QRCodeLine"];
//    self.scanLineImageView.frame = CGRectMake(0, 0, scanContent_W, scanLine_Height);
//    [self.scanContentView addSubview:self.scanLineImageView];
    
    UIView *topMaskView = [[UIView alloc] init];
    topMaskView.frame = CGRectMake(0, 0, self.frame.size.width, scanContent_Y);
    topMaskView.backgroundColor = UIColorFromRGB(0x2d2d2e,0.7);
    [self addSubview:topMaskView];
    
    UIView *leftMaskView = [[UIView alloc] init];
    leftMaskView.frame = CGRectMake(0, scanContent_Y, scanContent_X, scanContent_H);
    leftMaskView.backgroundColor = UIColorFromRGB(0x2d2d2e,0.7);
    [self addSubview:leftMaskView];
    
    UIView *rightMaskView = [[UIView alloc] init];
    rightMaskView.frame = CGRectMake(scanContent_X + scanContent_W, scanContent_Y,scanContent_X, scanContent_H);
    rightMaskView.backgroundColor = UIColorFromRGB(0x2d2d2e,0.7);
    [self addSubview:rightMaskView];
    
    UIView *bottomMaskView = [[UIView alloc] init];
    bottomMaskView.frame = CGRectMake(0, scanContent_Y + scanContent_H, self.frame.size.width, self.frame.size.height - ( scanContent_Y + scanContent_H));
    bottomMaskView.backgroundColor = UIColorFromRGB(0x2d2d2e,0.7);
    [self addSubview:bottomMaskView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"将商品二维码放入框内";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = UIColorFromRGB(0xececec,1);
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:titleLabel];
    [titleLabel sizeToFit];
    
    CGSize titleSize = titleLabel.frame.size;
    titleLabel.bounds = CGRectMake(0, 0, titleSize.width, titleSize.height);
    titleLabel.center = CGPointMake(self.frame.size.width/2.0, 78*SCALE + 64 + titleSize.height/2.0);
    
    CGFloat buttonWidth = 105*SCALE;
    CGFloat buttonHeight = 32*SCALE;
    CGFloat buttonX = (self.frame.size.width - buttonWidth)/2.0;
    CGFloat buttonY = self.frame.size.height - 90*SCALE - buttonHeight;
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clickButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    [clickButton setTitle:@"打开手电筒" forState:UIControlStateNormal];
    [clickButton setTitle:@"关闭手电筒" forState:UIControlStateSelected];
    [clickButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    clickButton.titleLabel.font = [UIFont systemFontOfSize:13];
    clickButton.layer.borderWidth = 0.6;
    clickButton.layer.borderColor = UIColorFromRGB(0xd0d0d0,1).CGColor;
    clickButton.layer.cornerRadius = 16*SCALE;
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
    sender.selected = !sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(scanView:clickAciton:)]) {
        _on = !_on;
        [self.delegate scanView:self clickAciton:_on];
    }
}


@end
