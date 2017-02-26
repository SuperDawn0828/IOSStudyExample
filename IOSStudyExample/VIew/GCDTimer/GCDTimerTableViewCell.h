//
//  GCDTimerTableViewCell.h
//  IOSStudyExample
//
//  Created by mac on 16/9/2.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCDTimerTableViewCell : UITableViewCell
@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,assign) NSTimeInterval interval;

@end
