//
//  PickerView.m
//  IOSStudyExample
//
//  Created by 黎明 on 16/9/7.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "PickerView.h"

#define SCREEN_FRAME ([UIScreen mainScreen].applicationFrame)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface PickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *_selectedDataArray;
    NSMutableArray *_dataSourceArray;
}
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *certainButton;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIImageView *indicatorImageView;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIPickerView *pickerView;

@end


@implementation PickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    self.backgroundView = [[UIView alloc]init];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 245);
    [self addSubview:self.backgroundView];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [UIColor blackColor];
    self.lineView.frame = CGRectMake(0, 49, SCREEN_WIDTH, 0.5);
    [self.backgroundView addSubview:self.lineView];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.cancelButton];
    [self.cancelButton sizeToFit];
    CGSize cancelSize = self.cancelButton.frame.size;
    self.cancelButton.frame = CGRectMake(15, (49 - cancelSize.height)/2.0, cancelSize.width, cancelSize.height);
    
    self.certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.certainButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.certainButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.certainButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.certainButton addTarget:self action:@selector(certainButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.certainButton];
    [self.certainButton sizeToFit];
    CGSize certainSize = self.certainButton.frame.size;
    self.certainButton.frame = CGRectMake(SCREEN_WIDTH - certainSize.width - 15, (49 - certainSize.height)/2.0, certainSize.width, certainSize.height);
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.backgroundView addSubview:self.titleLabel];
    
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.frame = CGRectMake(0, 49, SCREEN_WIDTH, 196);
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.backgroundView addSubview:self.pickerView];
    
    self.indicatorImageView = [[UIImageView alloc]init];
    self.indicatorImageView.image = [UIImage imageNamed:@"pickerview"];
    [self.backgroundView addSubview:self.indicatorImageView];
    [self.indicatorImageView sizeToFit];
    CGSize indicatorSize = self.indicatorImageView.frame.size;
    self.indicatorImageView.frame = CGRectMake(10, (196 - indicatorSize.height)/2.0 + 49, indicatorSize.width, indicatorSize.height);
}

- (void)cancelButtonAction:(UIButton *)sender
{
    [self hidden];
}

- (void)certainButtonAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:clickCertainForArray:)]) {
        [_delegate pickerView:self clickCertainForArray:_selectedDataArray];
    }
    
    [self hidden];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    CGSize titleSize = self.titleLabel.frame.size;
    self.titleLabel.frame = CGRectMake((SCREEN_WIDTH - titleSize.width)/2.0, (49 - titleSize.height)/2.0, titleSize.width, titleSize.height);
}

- (void)setupPickerViewDataWithArray:(NSArray *)dataArray
{
    if (!_selectedDataArray) {
        _selectedDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    [_dataSourceArray addObjectsFromArray:dataArray];
    
    if ([[_dataSourceArray firstObject] isKindOfClass:[NSArray class]]) {
        [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *data = (NSArray *)obj;
            [_selectedDataArray addObject:[data firstObject]];
            [_pickerView selectRow:0 inComponent:idx animated:NO];
        }];
    }
    else {
        [_selectedDataArray addObject:[dataArray firstObject]];
        [_pickerView selectRow:0 inComponent:0 animated:NO];
    }
    
    [self.pickerView reloadAllComponents];
}

- (void)updatePickerViewDataWithArray:(NSArray *)dataArray inComponent:(NSInteger)component
{
    [_dataSourceArray replaceObjectAtIndex:component withObject:dataArray];
    [self.pickerView selectRow:0 inComponent:component animated:YES];
    [self.pickerView reloadComponent:component];
    [self pickerView:self.pickerView didSelectRow:0 inComponent:component];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_dataSourceArray.count <= 0) {
        return 0;
    }
    
    if ([[_dataSourceArray firstObject] isKindOfClass:[NSArray class]]) {
        return _dataSourceArray.count;
    }
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_dataSourceArray.count <= 0) {
        return 0;
    }
    
    if ([[_dataSourceArray firstObject] isKindOfClass:[NSArray class]]) {
        return [_dataSourceArray[component] count];
    }
    
    return _dataSourceArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([[_dataSourceArray firstObject] isKindOfClass:[NSArray class]]) {
        return _dataSourceArray[component][row];
    }
    
    return _dataSourceArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *selectedStr = @"";
    if ([[_dataSourceArray firstObject] isKindOfClass:[NSArray class]]) {
        selectedStr = _dataSourceArray[component][row];
    }
    else {
        selectedStr = _dataSourceArray[row];
    }
    
    if ([selectedStr isEqualToString:_selectedDataArray[component]]) {
        return;
    }
    
    if ([[_dataSourceArray firstObject] isKindOfClass:[NSArray class]]) {
        [_selectedDataArray replaceObjectAtIndex:component withObject:_dataSourceArray[component][row]];
    }
    else {
        [_selectedDataArray replaceObjectAtIndex:component withObject:_dataSourceArray[row]];
    }
    
    [_delegate pickerView:self didSelectRow:row inComponent:component];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view == self) {
        [self hidden];
    }
}

- (void)show
{
    UIView *superView = [UIApplication sharedApplication].delegate.window;
    [superView addSubview:self];
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
                         self.backgroundView.frame = CGRectMake(0, SCREEN_HEIGHT - 245, SCREEN_WIDTH, 245);
                     } completion:^(BOOL finished) {
                         if (finished) {
                             
                         }
                     }];
}

- (void)hidden
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.backgroundColor = [UIColor clearColor];
                         self.backgroundView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 245);
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [self removeFromSuperview];
                         }
                     }];
}

@end
