//
//  GCDTimerTableViewCell.m
//  IOSStudyExample
//
//  Created by mac on 16/9/2.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "GCDTimerTableViewCell.h"
#import "GCDTimer.h"

@interface GCDTimerTableViewCell ()
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) GCDTimer *timer;

@end

@implementation GCDTimerTableViewCell

- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.textColor = [ColorHelper colorForTitle];
        _titleLable.font = [UIFont systemFontOfSize:14];
    }
    return _titleLable;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [ColorHelper colorForMain];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.layer.cornerRadius = SizeOfFloat(4);
        _timeLabel.layer.borderColor = [ColorHelper colorForMain].CGColor;
        _timeLabel.layer.borderWidth = SizeOfFloat(1);
    }
    return _timeLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [ColorHelper colorForLine];
    }
    return _lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.lineView];
        [self setSubviewsFrame];
        __weak typeof(self) weakSelf = self;
        self.timer = [GCDTimer timerWithInterval:1 delay:0 timerEventHeader:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.interval += 1;
            });
        }];
        [self.timer timerStart];
    }
    return self;
}

- (void)setSubviewsFrame
{
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(SizeOfFloat(30));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-SizeOfFloat(30));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SizeOfFloat(1)));
        make.centerY.mas_equalTo(self.contentView.mas_bottom);
    }];
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.titleLable.text = titleString;
}

- (void)setInterval:(NSTimeInterval)interval
{
    _interval = interval;
    [self updateTime:interval];
    
}

- (void)updateTime:(NSTimeInterval)interval
{
    NSString *time = [Util getDateTimeWithInterval:interval format:@"yyyy.MM.dd HH:mm:ss"];
    self.timeLabel.text = time;
}

@end
