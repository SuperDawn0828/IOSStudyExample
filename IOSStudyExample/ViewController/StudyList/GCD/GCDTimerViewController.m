//
//  GCDTimerViewController.m
//  IOSStudyExample
//
//  Created by mac on 16/9/2.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "GCDTimerViewController.h"
#import "GCDTimerTableViewCell.h"

@interface GCDTimerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation GCDTimerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"GCDTimer";
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [ColorHelper colorForBackground];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GCDTimerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[GCDTimerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.titleString = @"当前时间";
    cell.interval = [Util getCurrnentDateTimeInterval];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SizeOfFloat(100);
}

@end
