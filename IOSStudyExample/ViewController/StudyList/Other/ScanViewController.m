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

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,ScanViewDelegate,ScanningQRCodeDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic,strong) ScanningQRCodeManager *scanQRCode;
@property (nonatomic,strong) ScanView *scanView;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描";
    [self setupSubViews];
    [self setupScanningQRCode];
    [self.scanQRCode scanningQRCodeOutsideViewLayer:self.view.layer];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(openAlbumAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scanView createScanLineAnimation];
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
    self.scanView = [[ScanView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_STATUS_HEIGHT)];
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
    NSLog(@"outputDictionary:%@",outputDictionary);
}

@end
