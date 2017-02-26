//
//  ScanningQRCode.h
//  IOSStudyExample
//
//  Created by 黎明 on 16/10/12.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScanningQRCodeDelegate;

@interface ScanningQRCodeManager : NSObject
@property (nonatomic,assign) id <ScanningQRCodeDelegate> delegate;

+ (instancetype)scanningQRCode;


- (void)scanningQRCodeOutsideViewLayer:(CALayer *)layer;

- (void)stopScanning;
- (void)removePreviewLayer;
- (void)scanningOnTorch:(BOOL)on;

@end

@protocol ScanningQRCodeDelegate <NSObject>

@required
- (void)scanningQRCode:(ScanningQRCodeManager *)scanningQRCode completedScanningOutput:(NSDictionary *)outputDictionary;

@end
