//
//  PickerViewController.m
//  IOSStudyExample
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "PickerViewController.h"
#import "PickerView.h"

@interface PickerViewController ()<PickerViewDelegate>
{
    NSDictionary *_provinceDict;
    NSDictionary *_cityDict;
    NSArray *_provinceList;
    NSArray *_cityList;
    NSArray *_countyList;
}

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PickerView";
    
    [self getCitysList];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 68);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)getCitysList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@".plist"];
    _provinceDict = [[NSDictionary alloc]initWithContentsOfFile:path];
    _provinceList = [_provinceDict allKeys];
    _cityDict = [_provinceDict objectForKey:_provinceList[0]][0];
    _cityList = [_cityDict allKeys];
    _countyList = [_cityDict objectForKey:_cityList[0]];
}

- (void)buttonAction:(UIButton *)sender
{
    PickerView *subView = [[PickerView alloc]init];
    subView.delegate = self;
    subView.title = @"这里是标题";
    [subView show];
    [subView setupPickerViewDataWithArray:@[_provinceList,_cityList,_countyList]];
}

- (void)pickerView:(PickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _cityDict = [_provinceDict objectForKey:_provinceList[row]][0];
        _cityList = [_cityDict allKeys];
        [pickerView updatePickerViewDataWithArray:_cityList inComponent:component + 1];
    }
    else if (component == 1) {
        _countyList = _countyList = [_cityDict objectForKey:_cityList[row]];
        [pickerView updatePickerViewDataWithArray:_countyList inComponent:component + 1];
    }
    else {
        
    }
}

- (void)pickerView:(PickerView *)pickerView clickCertainForArray:(NSArray *)array
{
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"\n------->%@",(NSString *)obj);
    }];
}

@end
