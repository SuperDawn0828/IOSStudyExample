//
//  OtherStudyViewController.m
//  IOSStudyExample
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "OtherStudyViewController.h"
#import "DefaultTableViewCell.h"
#import "ScanQRAlertView.h"

@interface OtherStudyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *classNameList;

@end

@implementation OtherStudyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"OtherStudy";
    
    self.classNameList = @[@"PickerViewController",@"ScanViewController",@"QRCreateViewController",@"RuntimeViewController"];
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorHelper colorForBackground];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
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
//    NSString *className = self.classNameList[indexPath.row];
//    if ([className isEqualToString:@"ScanViewController"]) {
//        UIViewController *viewController = (UIViewController *)[[NSClassFromString(className) alloc]init];
//        UINavigationController *presentNav = [[UINavigationController alloc] initWithRootViewController:viewController];
//        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//        [rootVC presentViewController:presentNav animated:YES completion:nil];
//    }
//    else {
//        UIViewController *viewController = (UIViewController *)[[NSClassFromString(className) alloc]init];
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
    ScanQRAlertAction *cancelAtion = [ScanQRAlertAction actionWithTitle:@"" actionHandler:^(NSString *string) {
        
    }];
    
    ScanQRAlertAction *certainAction = [ScanQRAlertAction actionWithTitle:@"" actionHandler:^(NSString *string) {
        
    }];
    
    ScanQRAlertView *alertView = [ScanQRAlertView scanQRAlertDetail:@"dkjflksdjflkajdfklajdfkljdlkf" actionHandlers:@[cancelAtion,certainAction]];
    [alertView show];
    
}

@end
