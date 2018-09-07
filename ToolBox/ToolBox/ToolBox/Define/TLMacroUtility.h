//
//  IZCMacroUtility.h
//  iZichanSalary
//
//  Created by LoaforSpring on 16/4/27.
//  Copyright © 2016年 YiZhan. All rights reserved.
//
//  宏定义的方法

//#import "DYImage.h"
#import "TLThemeDefine.h"
#ifndef TLMacroUtility_h

#define TLMacroUtility_h

#import <UIKit/UIKit.h>

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//以下是从DevMacroUtility中挪移过来的

#define devShowChatCopyImageViewNotification @"devShowChatCopyImageViewNotification"
//键盘类型的key
#define DevInputBoardUserDefaultKey @"DevInputBoardUserDefaultKey"


////////////////////////////////////////////////////////////////////////////////////////

// warning:performSelector may cause a leak because its selecto
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define GetDevTongXieBundleRes(imageName) [NSString stringWithFormat:@"DYGameCenter.bundle/function/IM/%@", imageName]

//以上是从DevMacroUtility中挪移过来的
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UserDefaults

#define HLUserDefaluts [NSUserDefaults standardUserDefaults]
#define HLUserDefaultsSynchronize [HLUserDefaluts synchronize]

#define HLUserDefaultsSet(value, key) [HLUserDefaluts setValue:value forKey:key]
#define HLUserdefaultsValueForKey(key) [HLUserDefaluts valueForKey:key]

#define HLUserDefaultsSetObjectForKey(value, key) [HLUserDefaluts setObject:value forKey:key];
#define HLUserdefaultsObjectForKey(key) [HLUserDefaluts objectForKey:key]
#define HLUserDefaultsRemoveObjectForKey(key) [HLUserDefaluts removeObjectForKey:key]

#define HLUserDefaultsSetBoolValue(boolValue, key) [HLUserDefaluts setBool:boolValue forKey:key]
#define HLUserDefaultsdy_boolValueForKey(key) [HLUserDefaluts boolForKey:key]


#pragma mark - UI

/***********************ui属性**************************/
//#define kNavTableHeaderViewHeight (Dev_IOS_7_0 ? 64 : 44)
#define kNavTableHeaderViewHeight 0
#define kNavigationBarHeight 44
#define kStatusBarHeight 20

// 应用宽高
#define kHLApplicationFrame      [[UIScreen mainScreen] applicationFrame]
#define kHLApplicationFrameSize  [[UIScreen mainScreen] applicationFrame].size

#define kHLApplicationFrameWidth  kHLApplicationFrameSize.width
#define kHLApplicationFrameHeight kHLApplicationFrameSize.height

// 屏幕宽高
#define kHLScreenFrame      [[UIScreen mainScreen] bounds]
#define kHLScreenFrameSize  [[UIScreen mainScreen] bounds].size

#define kHLScreenFrameWidth  kHLScreenFrameSize.width
#define kHLScreenFrameHeight kHLScreenFrameSize.height

// 1、屏幕宽高
#define kDYScreenWidth     [UIScreen mainScreen].bounds.size.width
#define kDYScreenHeight        [UIScreen mainScreen].bounds.size.height

// 2、用宏定义检测block是否可用!
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };
// 3.获得RGB颜色
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 4.加入黑名单开关 (__USER_ID:登录用户id  __FRIEND_ID:加入黑名单的人的id)
#define kAddBlackList(__USER_ID, __FRIEND_ID) [NSString stringWithFormat:@"%@%@%@", @"addBlackList", __USER_ID, __FRIEND_ID]
#define kAddBlackListIM(__USER_ID) [NSString stringWithFormat:@"%@%@", @"addBlackList", __USER_ID]

// 屏幕缩放比例
#define kHLScreenScal [UIScreen mainScreen].scale

//屏幕的分辨率
#pragma mark - UIColorUtility
#define DevGetColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define DevGetColorFromHexA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define DevGetColorFromRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define DevGetColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define DevGetClearColor [UIColor clearColor]

#pragma mark - NSStringUtility
#define DevIntToString(i) [NSString stringWithFormat:@"%ld", i]

#define DevNSStringIsEmpty(str) ((str==nil)||[str isEqualToString:@"(null)"]||([str length]==0)||[str isEqualToString:@""])
#define DevNSArrayIsEmpty(arr) ((arr==nil)||([arr count]==0))
#define DevIsValidKey(key) ((key) != nil && ![key isKindOfClass:[NSNull class]])
#define DevIsValidValue(value) (((value) != nil) && ![value isKindOfClass:[NSNull class]])

/// 字符串检查到 nil / @"(null)" 返回 @"", (慎用)
#define DevNSStringFilterEmptyString(str) ((![str isKindOfClass:[NSString class]]||[((NSString *)str) isEqualToString:@"(null)"]) ? @"" : str)

// 将URL进行编码
#define HLGetWebEncodingURLString(str) [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

#define DevGetNoWhiteSpaceString(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

#pragma mark - UIFont
#define DevSystemFontOfSize(size) [UIFont systemFontOfSize:size]
#define DevBoldHLSystemFontOfSize(size) [UIFont boldSystemFontOfSize:size]

#pragma mark - UIImage
#define DevGetImage(imgName, imgType) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imgName ofType:imgType]]
#define DevGetPngImage(imgName) DevGetImage(imgName, @"png")
#define DevGetJpgImage(imgName) DevGetImage(imgName, @"jpg")

#pragma mark 系统版本小于v版本
#define DEV_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#pragma mark SystemVersion
#define DYCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define Dev_IOS_4_3 (DYCurrentSystemVersion>=4.3)
#define Dev_IOS_5_0 (DYCurrentSystemVersion>=5.0)
#define Dev_IOS_6_0 (DYCurrentSystemVersion>=6.0)
#define Dev_IOS_7_0 (DYCurrentSystemVersion>=7.0)
#define Dev_IOS_8_0 (DYCurrentSystemVersion>=8.0)
#define Dev_IOS_9_0 (DYCurrentSystemVersion>=9.0)
#define Dev_IOS_10_0 (DYCurrentSystemVersion>=10.0)
#define Dev_IOS7_OriginY (Dev_IOS_7_0?20:0)

#define Dev_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define Dev_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Dev_IS_RETINA (kHLScreenScal >= 2.0)

#define Dev_SCREEN_MAX_LENGTH (MAX(kHLScreenFrameWidth, kHLScreenFrameHeight))
#define Dev_SCREEN_MIN_LENGTH (MIN(kHLScreenFrameWidth, kHLScreenFrameHeight))

#define Dev_IS_IPHONE_4_OR_LESS (Dev_IS_IPHONE && Dev_SCREEN_MAX_LENGTH < 568.0)
#define Dev_IS_IPHONE_5 (Dev_IS_IPHONE && Dev_SCREEN_MAX_LENGTH == 568.0)
#define Dev_IS_IPHONE_6 (Dev_IS_IPHONE && Dev_SCREEN_MAX_LENGTH == 667.0)
#define Dev_IS_IPHONE_6P (Dev_IS_IPHONE && Dev_SCREEN_MAX_LENGTH == 736.0)

#define Dev_IS_IPHONE_X (Dev_IS_IPHONE && Dev_SCREEN_MAX_LENGTH == 812.0)
#define kCustomSafeNavigationBarHeight (Dev_IS_IPHONE_X ? 88 : 64)//导航栏安全距离
#define kCustomSafeBottomHeight (Dev_IS_IPHONE_X ? 34 : 0)//底部安全距离
#define  kCustomSafeTopHeight      (Dev_IS_IPHONE_X ? 24.f : 0)
#define  kCustomSafeTabbarHeight         (Dev_IS_IPHONE_X ? (49.f+34.f) : 49.f)

// 以下代码针对设计图全是750的情况做的折中处理，根据屏幕的不同尺寸，自动计算结果
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"

// 20171224-增加用于快速创建一个weakSelf
#define DYWeakSelf __weak typeof(self) weakSelf = self;

//20180522 - 添加一个圈子视频支持的最大时间
#define DYCircleMaxDuration 30

// 换算比率
static CGFloat LSGetScreenRate() {
    CGFloat screenWidth = kHLScreenFrameWidth;
    return (screenWidth/(375.0));
}
//红包大厅 适配iPhone X 的比例-wqq-2018-01-08
static CGFloat LSGetScreenRate2() {
    CGFloat screenWidth = kHLScreenFrameWidth*kHLScreenScal;//iphone X  kHLScreenScal = 3.0；6s  kHLScreenScal = 2.0
    return (screenWidth/(375.0*2.0));//红包大厅的UI图是按照6s的比例出的图，so~
}
// 按照比例获取一个浮点数
static CGFloat LSGetAutoRateNum(CGFloat num) {
    if (kHLScreenFrameWidth == 375) {
        return num;
    }
    return ceilf(num * LSGetScreenRate());
}

// 按照比例获取一个CGPoint
static CGPoint LSGetAutoRatePoint(CGPoint point) {
    if (kHLScreenFrameWidth == 375) {
        return point;
    }
    CGFloat screenRate = LSGetScreenRate();
    
    return (CGPointMake(ceilf(point.x * screenRate), ceilf(point.y * screenRate)));
}

// 按照比例获取一个CGRect
static CGRect LSGetAutoRateFrame(CGRect rect) {
    if (kHLScreenFrameWidth == 375) {
        return rect;
    }
    CGFloat screenRate = LSGetScreenRate();
    
    return (CGRectMake(ceilf(rect.origin.x*screenRate), ceilf(rect.origin.y*screenRate), ceilf(rect.size.width*screenRate), ceilf(rect.size.height*screenRate)));
}


#pragma clang diagnostic pop

// 宏定义形式的换算比率
#define kLSScreenRate LSGetScreenRate()

#endif /* IZCMacroUtility_h */
