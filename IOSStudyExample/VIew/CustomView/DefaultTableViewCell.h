//
//  DefaultTableViewCell.h
//  IOSStudyExample
//
//  Created by mac on 16/8/31.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultTableViewCell : UITableViewCell
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *detail;
@property (nonatomic,strong) UIColor *detailColor;
@property (nonatomic,strong) UIImage *iconImage;
@property (nonatomic,assign) BOOL showSeparator;
@property (nonatomic,assign) BOOL showIndeicate;

@end
