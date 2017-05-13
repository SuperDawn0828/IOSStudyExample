//
//  ScanQRAlertView.m
//  IOSStudyExample
//
//  Created by 黎明 on 2017/4/1.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "ScanQRAlertView.h"

@interface ScanQRAlertView ()
@property (nonatomic,strong) NSString *detail;
@property (nonatomic,strong) NSArray *handlers;

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIImageView *bankgroundImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIButton *certainButton;

@end

@implementation ScanQRAlertView

- (instancetype)initWithScanQRAlertDetail:(NSString *)detail actionHandlers:(NSArray *)handlers
{
    self = [super init];
    if (self) {
        self.detail = detail;
        self.handlers = handlers;
        [self setupSubViews];
    }
    return self;
}

+ (instancetype)scanQRAlertDetail:(NSString *)detail actionHandlers:(NSArray *)handlers
{
    return [[self alloc] initWithScanQRAlertDetail:detail actionHandlers:handlers];
}

- (void)setupSubViews
{
    self.backgroundColor = [UIColor clearColor];
    self.frame = self.superview.frame;
    
    UIImage *backgroundImage = [UIImage imageNamed:@"diban"];
    CGSize contentSize = backgroundImage.size;
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.bounds = CGRectMake(0, 0, contentSize.width, contentSize.height);
    self.contentView.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    [self addSubview:self.contentView];
    
    self.bankgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    self.bankgroundImageView.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
    [self.contentView addSubview:self.bankgroundImageView];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.text = @"是否立即加载到场景中？";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = UIColorFromRGB(0x444a59);
    self.titleLabel.numberOfLines = 1;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel sizeToFit];
    self.titleLabel.center = CGPointMake(contentSize.width/2.0, 57);
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    self.detailLabel.textColor = UIColorFromRGB(0x666666);
    self.detailLabel.numberOfLines = 2;
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.text = [NSString stringWithFormat:@"商品名称：%@",self.detail];
    [self.contentView addSubview:self.detailLabel];
    self.detailLabel.bounds = CGRectMake(0, 0, 238, 40);
    self.detailLabel.center = CGPointMake(contentSize.width/2.0, 100);
    
    CGFloat buttonCenterY = contentSize.height - 30 - 17;
    CGFloat cancelButtonCenterX = contentSize.width/2.0 - 64;
    CGFloat certainButtonCenterX = contentSize.width/2.0 + 64;
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.backgroundColor = UIColorFromRGB(0x999999);
    self.cancelButton.layer.cornerRadius = 3;
    [self.contentView addSubview:self.cancelButton];
    self.cancelButton.bounds = CGRectMake(0, 0, 104, 34);
    self.cancelButton.center = CGPointMake(cancelButtonCenterX, buttonCenterY);
    
    self.certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.certainButton setTitle:@"立即加载" forState:UIControlStateNormal];
    [self.certainButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    self.certainButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.certainButton.backgroundColor = UIColorFromRGB(0x1677cb);
    self.certainButton.layer.cornerRadius = 3;
    [self.certainButton addTarget:self action:@selector(certainAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.certainButton];
    self.certainButton.bounds = CGRectMake(0, 0, 104, 34);
    self.certainButton.center = CGPointMake(certainButtonCenterX, buttonCenterY);
}

- (void)cancelAction:(UIButton *)sender
{
    if (self.handlers.count >= 2) {
        ScanQRAlertAction *action = self.handlers[0];
        if (action.handler) {
            action.handler(nil);
        }
    }
    [self hide];
}

- (void)certainAction:(UIButton *)sender
{
    if (self.handlers.count >= 2) {
        ScanQRAlertAction *action = self.handlers[1];
        if (action.handler) {
            action.handler(nil);
        }
    }
    [self hide];
}

- (void)show
{
    UIView *superView = [UIApplication sharedApplication].delegate.window;
    [superView addSubview:self];
    self.frame = superView.frame;
    
    
    self.contentView.alpha = 0;
    self.contentView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2);
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                            self.contentView.alpha = 1;
                            self.contentView.layer.transform = CATransform3DIdentity;
                        } completion:^(BOOL finished) {
        
                        }];
}

- (void)hide
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                            self.contentView.alpha = 0;
                        } completion:^(BOOL finished) {
                            [self removeFromSuperview];
                        }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view == self) {
        [self hide];
    }
}


@end

@interface ScanQRAlertAction ()


@end

@implementation ScanQRAlertAction

- (instancetype)initWithTitle:(NSString *)title actionHandler:(ActionHandler)handler
{
    self = [super init];
    if (self) {
        self.title = title;
        self.handler = handler;
    }
    return self;
}

+ (instancetype)actionWithTitle:(NSString *)title actionHandler:(ActionHandler)handler
{
    return [[self alloc] initWithTitle:title actionHandler:handler];
}

@end
