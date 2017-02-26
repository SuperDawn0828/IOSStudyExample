//
//  PickerView.h
//  IOSStudyExample
//
//  Created by 黎明 on 16/9/7.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerView;

@protocol PickerViewDelegate <NSObject>

@required
- (void)pickerView:(PickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@optional
- (void)pickerView:(PickerView *)pickerView clickCertainForArray:(NSArray *)array;

@end

@interface PickerView : UIView
@property (nonatomic,assign) id <PickerViewDelegate> delegate;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) CGFloat rowHeight;

- (void)setupPickerViewDataWithArray:(NSArray *)dataArray;

- (void)updatePickerViewDataWithArray:(NSArray *)dataArray inComponent:(NSInteger)component;

- (void)show;

@end
