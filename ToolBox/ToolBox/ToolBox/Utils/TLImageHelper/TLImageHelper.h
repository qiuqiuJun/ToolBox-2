//
//  TLImageHelper.h
//  ToolBox
//
//  Created by DOUBLEQ on 2018/9/7.
//  Copyright © 2018年 DOUBLE Q. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TLImageHelper : NSObject
//UIImage模糊滤镜处理
+ (UIImage *)filterImage:(UIImage *)image value:(CGFloat)value;

/**
 生成二维码UIImage

 @param informationString 要生成的内容信息
 @param frontColor 前置颜色
 @param bgColor 背景颜色
 @param qrSize 要生成的二维码的大小
 @return 生成的二维码
 */
+ (UIImage *)createQrCode:(NSString *)informationString frontColor:(UIColor *)frontColor qrBgColor:(UIColor *)bgColor qrSize:(CGSize)qrSize;

/**
 二维码清晰化处理

 @param image 原二维码
 @param qrSize 二维码的大小
 @return 清晰化处理后的二维码
 */
+ (UIImage *)clearnessImage:(CIImage *)image qrSize:(CGSize)qrSize;

/**
 给二维码添加logo

 @param qrCodeImage 二维码
 @param logoImage 要添加的logo
 @return 返回合成后的二维码
 */
+ (UIImage *)insertLogoInQrCodeImage:(UIImage *)qrCodeImage logoImage:(UIImage *)logoImage;
@end
