//
//  DefaultTableViewCell.m
//  IOSStudyExample
//
//  Created by mac on 16/8/31.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "DefaultTableViewCell.h"

@interface DefaultTableViewCell ()
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIImageView *indicteImageView;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;

@end

@implementation DefaultTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.indicteImageView];
        [self.contentView addSubview:self.lineView];
        [self layoutCellSubviews];
    }
    return self;
}

- (void)layoutCellSubviews
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(SizeOfFloat(30));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(SizeOfFloat(30));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.centerY.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@(SizeOfFloat(1)));
    }];
    
    [self.indicteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-SizeOfFloat(30));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-SizeOfFloat(30));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UIImageView *)indicteImageView
{
    if (!_indicteImageView) {
        _indicteImageView = [[UIImageView alloc] init];
        _indicteImageView.image = [UIImage imageNamed:@"image_right"];
        _indicteImageView.hidden = YES;
    }
    return _indicteImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font = [UIFont systemFontOfSize:14];
    }
    return _detailLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [ColorHelper colorForLine];
    }
    return _lineView;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setDetail:(NSString *)detail
{
    _detail = detail;
    self.detailLabel.text = detail;
}

- (void)setDetailColor:(UIColor *)detailColor
{
    _detailColor = detailColor;
    self.detailLabel.textColor = detailColor;
}

- (void)setShowSeparator:(BOOL)showSeparator
{
    _showSeparator = showSeparator;
    self.lineView.hidden = !showSeparator;
}

- (void)setIconImage:(UIImage *)iconImage
{
    _iconImage = iconImage;
    if (iconImage) {
        self.iconImageView.image = iconImage;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(SizeOfFloat(20));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
}

- (void)setShowIndeicate:(BOOL)showIndeicate
{
    _showIndeicate = showIndeicate;
    self.indicteImageView.hidden = !showIndeicate;
    if (showIndeicate) {
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.iconImageView.mas_left).offset(-SizeOfFloat(20));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
}

@end
