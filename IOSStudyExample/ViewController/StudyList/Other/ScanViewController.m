//
//  ScanViewController.m
//  IOSStudyExample
//
//  Created by 黎明 on 16/10/10.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanView.h"
#import "ScanningQRCodeManager.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,ScanViewDelegate,ScanningQRCodeDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic,strong) ScanningQRCodeManager *scanQRCode;
@property (nonatomic,strong) ScanView *scanView;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self setupScanningQRCode];
    [self.scanQRCode scanningQRCodeOutsideViewLayer:self.view.layer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x444a59)];
    
    UIImage *backImage = [[UIImage imageNamed:@"back-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickButton setBackgroundImage:backImage forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:clickButton];
    self.navigationController.navigationItem.leftBarButtonItem = buttonItem;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.scanQRCode scanningOnTorch:NO];
}

- (void)openAlbumAction
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:(NSString *)UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:^{
            [self scanQRCodeFromPhotosInTheAlbum:theImage];
        }];
        return;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)scanQRCodeFromPhotosInTheAlbum:(UIImage *)image
{
    CIDetector *detector = [CIDetector  detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count > 0) {
        CIQRCodeFeature *feature = features[0];
        NSString *scannedResult = feature.messageString;
        NSLog(@"scannedResult:%@",scannedResult);
    }
    else {
        
    }
}

- (void)setupSubViews
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.scanView = [[ScanView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.scanView.delegate = self;
    [self.view addSubview:self.scanView];
}

- (void)setupScanningQRCode
{
    self.scanQRCode = [ScanningQRCodeManager scanningQRCode];
    self.scanQRCode.delegate = self;
}

- (void)scanView:(ScanView *)view clickAciton:(BOOL)on
{
    [self.scanQRCode scanningOnTorch:on];
}

- (void)scanningQRCode:(ScanningQRCodeManager *)scanningQRCode completedScanningOutput:(NSDictionary *)outputDictionary
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:outputDictionary[@"type"] message:outputDictionary[@"stringValue"] preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction *certainAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (weakSelf.scanQrCodeResult) {
            weakSelf.scanQrCodeResult(outputDictionary[@"stringValue"]);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        [weakSelf.scanQRCode startScanning];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:certainAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    NSLog(@"outputDictionary:%@",outputDictionary);
}

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
