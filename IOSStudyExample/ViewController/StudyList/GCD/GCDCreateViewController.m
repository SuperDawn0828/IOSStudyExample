//
//  GCDCreateViewController.m
//  IOSStudyExample
//
//  Created by 黎明 on 16/9/30.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "GCDCreateViewController.h"

@interface GCDCreateViewController ()

@end

@implementation GCDCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSerialDispatch];
}

- (void)createSerialDispatch
{
    //生成串行队列
    dispatch_queue_t serialQueue0 = dispatch_queue_create("serialqueue0", DISPATCH_QUEUE_SERIAL);
    
    /*
     *多个线程更新相同资源导致数据竞争时可以使用
     */
    dispatch_async(serialQueue0, ^{
        NSLog(@"block01");
    });
    dispatch_async(serialQueue0, ^{
        NSLog(@"block02");
    });
    dispatch_async(serialQueue0, ^{
        NSLog(@"block03");
    });
    dispatch_async(serialQueue0, ^{
        NSLog(@"block04");
    });
    
    //获取并发队列
    dispatch_queue_t concurrentqueue = dispatch_queue_create("concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentqueue, ^{
        NSLog(@"concurrentqueueblock0");
    });
    dispatch_async(concurrentqueue, ^{
        NSLog(@"concurrentqueueblock1");
    });
    dispatch_async(concurrentqueue, ^{
        NSLog(@"concurrentqueueblock2");
    });
    dispatch_async(concurrentqueue, ^{
        NSLog(@"concurrentqueueblock3");
        NSLog(@"%d",[NSThread isMainThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%d",[NSThread isMainThread]);
        });
    });
    
    dispatch_queue_t mainqueue = dispatch_get_main_queue();
    dispatch_async(mainqueue, ^{
        NSLog(@"mainqueue");
        NSLog(@"%d",[NSThread isMainThread]);
    });
    
    //系统提供的并行队列，可以直接使用，设置优先级
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSLog(@"this is a globalconcurrentqueue");
    });
    
    //低优先级获取方法
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSLog(@"---low---");
    });
    //高优先级获取方法
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"---high---");
    });
    //后台优先级获取方法
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSLog(@"---background---");
    });
    //默认优先级获取方法
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"---default---");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
