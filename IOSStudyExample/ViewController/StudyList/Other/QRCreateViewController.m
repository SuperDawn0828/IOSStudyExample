//
//  QRCreateViewController.m
//  IOSStudyExample
//
//  Created by 黎明 on 16/10/12.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "QRCreateViewController.h"

@interface QRCreateViewController ()

@end

@implementation QRCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生成二维码";

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100, 50, 100, 100);
    imageView.image = [self createDefaultQRCode:@"http://www.baidu.com"];
    [self.view addSubview:imageView];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.frame = CGRectMake(100, 200, 100, 100);
    iconImageView.image = [self addIconQRCode:[self createDefaultQRCode:@"weixin_0504china"] icon:[UIImage imageNamed:@"icon_image"]];
    [self.view addSubview:iconImageView];
    
    UIImageView *colorImageView = [[UIImageView alloc] init];
    colorImageView.frame = CGRectMake(100, 350, 100, 100);
    colorImageView.image = [self createColorQRCode:@"http://www.cctv.com"];
    [self.view addSubview:colorImageView];
}

- (UIImage *)createDefaultQRCode:(NSString *)info
{
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    [filter setValue:infoData forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    UIImage *image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:150];
    return image;
}

- (UIImage *)addIconQRCode:(UIImage *)QRCode icon:(UIImage *)icon
{
    CGSize QRCodeSize = QRCode.size;
    
    UIGraphicsBeginImageContext(QRCodeSize);
    [QRCode drawInRect:CGRectMake(0, 0, QRCodeSize.width, QRCodeSize.height)];
    [icon drawInRect:CGRectMake((QRCodeSize.width - 30)/2.0, (QRCodeSize.height - 30)/2.0, 30, 30)];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

- (UIImage *)createColorQRCode:(NSString *)info
{
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    [filter setValue:infoData forKey:@"inputMessage"];
    CIImage *defauleImage = [filter outputImage];
    
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorFilter setDefaults];
    [colorFilter setValue:defauleImage forKey:@"inputImage"];
    [colorFilter setValue:[CIColor grayColor] forKey:@"inputColor0"];
    [colorFilter setValue:[CIColor blueColor] forKey:@"inputColor1"];
    CIImage *outPutImage = [colorFilter outputImage];
    UIImage *finalImage = [self createNonInterpolatedUIImageFormCIImage:outPutImage withSize:150];
    return finalImage;
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
