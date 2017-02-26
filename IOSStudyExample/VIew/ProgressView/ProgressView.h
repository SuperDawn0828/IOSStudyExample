//
//  ProgressView.h
//  IOSStudyExample
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,strong) UIColor *tintColor;
@property (nonatomic,strong) UIColor *progressColor;
@property (nonatomic,assign) CGFloat duration;

- (void)setProgressValue:(CGFloat)value animated:(BOOL)animated;

@end
