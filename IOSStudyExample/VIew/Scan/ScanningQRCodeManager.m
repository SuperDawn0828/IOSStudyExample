//
//  ScanningQRCode.m
//  IOSStudyExample
//
//  Created by 黎明 on 16/10/12.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "ScanningQRCodeManager.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanningQRCodeManager ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic,strong) AVCaptureDevice *captureDevice;

@end

@implementation ScanningQRCodeManager

+ (instancetype)scanningQRCode
{
    return[[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return self;
}

- (void)scanningQRCodeOutsideViewLayer:(CALayer *)layer
{
    // 1、获取摄像设备
    //    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:nil];
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    // 注：微信二维码的扫描范围是整个屏幕， 这里并没有做处理（可不用设置）
    output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 5、 初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    // 5.1 添加会话输入
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    else {
        return;
    }
    
    // 5.2 添加会话输出
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    else {
        return;
    }

    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.previewLayer.frame = CGRectMake(0, 0, width, height);
    // 8、将图层插入当前视图
    [layer insertSublayer:self.previewLayer atIndex:0];
    // 9、启动会话
    [self startScanning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // 0. 扫描成功之后的提示音
    [self playSoundEffect:@"sound.caf"];
    // 1. 如果扫描完成，停止会话
    [self stopScanning];
    //    // 2. 删除预览图层
    //    [self.previewLayer removeFromSuperlayer];
    // 3. 设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *object = metadataObjects[0];
        NSDictionary *objectDict = @{@"type":object.type,
                                     @"stringValue":object.stringValue};
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(scanningQRCode:completedScanningOutput:)]) {
            [self.delegate scanningQRCode:self completedScanningOutput:objectDict];
        }
    }
}

- (void)scanningOnTorch:(BOOL)on
{
    if ([self.captureDevice hasTorch]) {
        [self.captureDevice lockForConfiguration:nil];
        if (on) {
            [self.captureDevice setTorchMode:AVCaptureTorchModeOn];
        }
        else {
            [self.captureDevice setTorchMode:AVCaptureTorchModeOff];
        }
        [self.captureDevice unlockForConfiguration];
    }
    else {
        
    }
}

- (void)startScanning
{
    [self.session startRunning];
}

- (void)stopScanning
{
    [self.session stopRunning];
}

- (void)removePreviewLayer
{
    [self.previewLayer removeFromSuperlayer];
}

- (void)playSoundEffect:(NSString *)soundName
{
    NSString *fileUrl = [[NSBundle mainBundle] pathForResource:soundName ofType:nil];
    NSURL *url = [NSURL URLWithString:fileUrl];
    
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundPlayCompleteCallback, NULL);
    AudioServicesPlaySystemSound(soundID);
}

void soundPlayCompleteCallback(SystemSoundID soundID,void * clientData) {
    NSLog(@"扫描完成");
}

@end
