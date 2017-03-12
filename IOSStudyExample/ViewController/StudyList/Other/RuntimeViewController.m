//
//  RuntimeViewController.m
//  IOSStudyExample
//
//  Created by 黎明 on 2017/3/2.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "RuntimeViewController.h"
#import "RuntimeModel.h"
#import <objc/runtime.h>

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    RuntimeModel *timeModel = [[RuntimeModel alloc] init];
    
    unsigned int countOut, i;
    
    objc_property_t *propertys = class_copyPropertyList([RuntimeModel class], &countOut);
    for (i = 0; i < countOut; i++) {
        objc_property_t property = propertys[i];
        
        const char *propName = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName:%@",propertyName);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
