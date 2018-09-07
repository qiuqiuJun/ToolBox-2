//
//  DYStringKit.m
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/17.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import "TLStringKit.h"
#import <CommonCrypto/CommonDigest.h>
#import "TLMacroUtility.h"

@implementation TLStringKit

+ (CGSize)getStringProperSize:(NSString *)textString
                         font:(UIFont *)font
                        width:(float)width
{
    CGSize textSize = CGSizeZero;
    #if __IPHONE_7_0
    {
    // NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
    // NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
        // 计算文本的大小
        textSize = [textString boundingRectWithSize:CGSizeMake(width, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                            options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制de时的附加选项
                                         attributes:@{NSFontAttributeName:font}        // 文字的属性
                                            context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
//        DYLog(@"w = %f", textSize.width);
//        DYLog(@"h = %f", textSize.height);
    }
    #else
    {
        textSize = [textString sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    }
    #endif

    return textSize;
}

+ (CGSize)getStringProperSize:(NSString *)textString
                         font:(UIFont *)font
{
    CGSize textSize = CGSizeZero;
    
    #if __IPHONE_7_0
    {
        textSize = [textString sizeWithAttributes:@{NSFontAttributeName:font}];
    }
    #else
    {
        textSize = [textString sizeWithFont:font];
    }
    #endif
    
    return textSize;
}

#pragma mark --- sha256加密方式
+ (NSString *)getSha256String:(NSString *)srcString {
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/**
 *  此方法随机产生20位字符串， 修改代码红色数字可以改变 随机产生的位数
 *
 *  @return 20位随机数
 */
+ (NSString *)getRet20bitString
{
    char data[20];
    for (int x=0;x<20;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:20 encoding:NSUTF8StringEncoding];
}

/**
 *  字符串是否包含aString
 *
 *  @param mString 原字符串参数
 *  @param aString 包含字符串参数
 *
 *  @return 是否包含
 */
+ (BOOL)devString:(NSString *)mString containsString:(NSString *)aString
{
    if (Dev_IOS_8_0) {
        return [mString containsString:aString];
    }
    else
    {
        //判断mString 是否含有aString
        if([mString rangeOfString:aString].location !=NSNotFound)//_roaldSearchText
        {
            return YES;
        }
    }
    
    return NO;
}



/**
 *  知道一段文字，求导更改行高后的高度
 *  add by yly
 *  @param width 屏幕的宽
 *  @param string 更改行高的文字
 *
 *  @return 是否包含
 */
+ (CGSize)getTheHeightOgTheUILabelWithTheWidth:(CGFloat)width andTheString:(NSString *)string
{
    CGSize titleHeight;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, width - 20, 20)];
    titleLab.font = [UIFont boldSystemFontOfSize:17.0f];
    titleLab.numberOfLines = 0;
    titleLab.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    titleLab.text = string;
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:titleLab.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [titleLab.text length])];
    [titleLab setAttributedText:attributedString1];
    [titleLab sizeToFit];
    titleHeight.height = titleLab.frame.size.height;
    
    
//    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_titleLab.text];
//    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle1 setLineSpacing:5];
//    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_titleLab.text length])];
//    [_titleLab setAttributedText:attributedString1];
//    [_titleLab sizeToFit];
//    
//    _titleLab.height = _titleLab.frame.size.height;
//    
//    CGSize titleSize = [DYStringKit getStringProperSize:_titleLab.text font:DevSystemFontOfSize(17) width:_bgView.width - 20];
//    if (titleSize.height < _titleLab.height)
//    {
//        titleSize.height = _titleLab.height;
//    }
    
    
    CGSize titleSize = [TLStringKit getStringProperSize:titleLab.text font:DevSystemFontOfSize(17) width:width - 20];
    
    if (titleSize.height < titleHeight.height)
    {
        titleSize.height = titleHeight.height;
    }

    return titleSize;
}
/**
 字典和数组转化为不包含空格的字符串
 
 @param object 数组或者字典对象
 @return 处理后的json字符串
 */
+(NSString *)convertToJsonStr:(id)object{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
//        DYLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}
@end
