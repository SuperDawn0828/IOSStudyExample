//
//  ProgressView.m
//  IOSStudyExample
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "ProgressView.h"

static NSString *kProgressAnimationKey = @"kProgressAnimationKey";

@interface ProgressView ()
{
    CGFloat _progress;
}
@property (nonatomic,strong) CAShapeLayer *trackLayer;
@property (nonatomic,strong) CAShapeLayer *progressLayer;
@property (nonatomic,strong) UIBezierPath *bezierPath;

@end

@implementation ProgressView

- (CAShapeLayer *)trackLayer
{
    if (!_trackLayer) {
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _trackLayer;
}

- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeEnd = 0.0;
    }
    return _progressLayer;
}

- (UIBezierPath *)bezierPath
{
    CGSize size = self.frame.size;
    CGFloat width = (size.width <= size.height)?size.width:size.height;
    CGFloat startAngle = -M_PI/2.0;
    CGFloat endAngle = startAngle + 2*M_PI;
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPath];
    }
    [_bezierPath removeAllPoints];
    [_bezierPath addArcWithCenter:CGPointMake(size.width/2.0, size.height/2.0)
                           radius:width/2.0
                       startAngle:startAngle
                         endAngle:endAngle
                        clockwise:YES];
    return _bezierPath;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.layer addSublayer:self.trackLayer];
        [self.layer addSublayer:self.progressLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.trackLayer];
        [self.layer addSublayer:self.progressLayer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    CGFloat width = (size.width <= size.height)?size.width:size.height;
    
    self.trackLayer.frame = CGRectMake((size.width - width)/2.0, (size.height - width)/2.0, width, width);
    self.progressLayer.frame = CGRectMake((size.width - width)/2.0, (size.height - width)/2.0, width, width);
    self.trackLayer.path = self.bezierPath.CGPath;
    self.progressLayer.path = self.bezierPath.CGPath;
}

- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    self.trackLayer.strokeColor = tintColor.CGColor;
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgressValue:(CGFloat)value animated:(BOOL)animated
{
    if (_progress == value) {
        return;
    }
    
    if (animated) {
        [self animationWithValue:value];
    }
    else {
        [self upDateProgressValue:value];
    }
    
    _progress = value;
}

- (void)animationWithValue:(CGFloat)value
{
    if (value >= 1.0) {
        value = 1.0;
    }
    
    CGFloat animationDuration = ABS((value - _progress)*self.duration);
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setValue:@(animationDuration) forKey:kCATransactionAnimationDuration];
    self.progressLayer.strokeEnd = value;
    [CATransaction commit];
}

- (void)upDateProgressValue:(CGFloat)value
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.progressLayer.strokeEnd = value;
    [CATransaction commit];
}

@end
