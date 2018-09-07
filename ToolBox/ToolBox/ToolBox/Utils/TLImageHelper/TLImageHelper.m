//
//  TLImageHelper.m
//  ToolBox
//
//  Created by DOUBLEQ on 2018/9/7.
//  Copyright © 2018年 DOUBLE Q. All rights reserved.
//

#import "TLImageHelper.h"

@implementation TLImageHelper
//模糊滤镜
+ (UIImage *)filterImage:(UIImage *)image value:(CGFloat)value{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    //将图片输入到滤镜中
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    //设置模糊程度
    [blurFilter setValue:@(value) forKey:@"inputRadius"];
    NSLog(@"查看blurFilter的属性--- %@",blurFilter.attributes);
    //将处理之后的图片输出
    CIImage *outCiImage = [blurFilter valueForKey:kCIOutputImageKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    //获取CGImage句柄
    CGImageRef outCGImageRef = [context createCGImage:outCiImage fromRect:[outCiImage extent]];
    //获取到最终图片
    UIImage *resultImage = [UIImage imageWithCGImage:outCGImageRef];
    
    //释放句柄
    CGImageRelease(outCGImageRef);
    return resultImage;
}
//根据内容和二维码的颜色生成二维码
+ (UIImage *)createQrCode:(NSString *)informationString frontColor:(UIColor *)frontColor qrBgColor:(UIColor *)bgColor qrSize:(CGSize)qrSize{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [informationString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    //5.设置二维码的前景色和背景颜色
    CIFilter *colorFilter=[CIFilter filterWithName:@"CIFalseColor"];
    //5.1设置默认值
    [colorFilter setDefaults];
    [colorFilter setValue:outputImage forKey:@"inputImage"];
    [colorFilter setValue:[CIColor colorWithCGColor:frontColor.CGColor] forKey:@"inputColor0"];//[CIColor colorWithRed:0 green:0 blue:255]
    [colorFilter setValue:[CIColor colorWithCGColor:bgColor.CGColor] forKey:@"inputColor1"];//[CIColor colorWithRed:1 green:1 blue:1]
    //5.3获取生存的图片
    outputImage=colorFilter.outputImage;
    CGAffineTransform scale=CGAffineTransformMakeScale(10, 10);
    outputImage=[outputImage imageByApplyingTransform:scale];
    //二维码清晰化处理
    return [self clearnessImage:outputImage qrSize:qrSize];
}
//二维码清晰化处理
+ (UIImage *)clearnessImage:(CIImage *)image qrSize:(CGSize)qrSize{
    //二维码清晰化处理
    CGFloat scaleX = qrSize.width / image.extent.size.width;
    CGFloat scaleY = qrSize.height / image.extent.size.height;
    CIImage *newImage= [image imageByApplyingTransform:CGAffineTransformMakeScale(scaleX, scaleY)];
    return  [UIImage imageWithCIImage:newImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
}
//添加logo
+ (UIImage *)insertLogoInQrCodeImage:(UIImage *)qrCodeImage logoImage:(UIImage *)logoImage {
    //使用mainScreen的scale，否则会模糊
    UIGraphicsBeginImageContextWithOptions(qrCodeImage.size, NO, [[UIScreen mainScreen] scale]);
    [qrCodeImage drawInRect:CGRectMake(0, 0, qrCodeImage.size.width, qrCodeImage.size.height)];
    CGFloat logoImageX = (qrCodeImage.size.width - 20) / 2;
    CGFloat logoImageY = (qrCodeImage.size.height - 20) / 2;
    CGFloat logoImageWidth = 20;
    CGFloat logoImageHeight = 20;
    [logoImage drawInRect:CGRectMake(logoImageX, logoImageY, logoImageWidth, logoImageHeight)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+(UIImage *)imageResize:(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
