//
//  ScanViewController.h
//  IOSStudyExample
//
//  Created by 黎明 on 16/10/10.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CallBackBlock)(NSString *string);

@interface ScanViewController : UIViewController
@property (nonatomic,copy) CallBackBlock scanQrCodeResult;

@end
