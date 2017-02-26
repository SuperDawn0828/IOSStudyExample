//
//  LayerStudyViewController.m
//  IOSStudyExample
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "LayerStudyViewController.h"
#import "DefaultTableViewCell.h"

@interface LayerStudyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *classNameList;

@end

@implementation LayerStudyViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [ColorHelper colorForBackground];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"layer学习";
    
    self.classNameList = @[@"ProgressViewController",@"KeyframeAnimaitonViewController",@"TransitionViewController"];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classNameList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = self.classNameList[indexPath.row];
    DefaultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DefaultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.title = className;
    if ([[self.classNameList lastObject] isEqualToString:className]) {
        cell.showSeparator = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SizeOfFloat(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = self.classNameList[indexPath.row];
    UIViewController *viewController = (UIViewController *)[[NSClassFromString(className) alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
