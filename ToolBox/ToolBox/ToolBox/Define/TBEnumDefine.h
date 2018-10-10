//
//  TBEnumDefine.h
//  ToolBox
//
//  Created by wqq on 2018/9/9.
//  Copyright © 2018年 DOUBLE Q. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,QRType) {
    QRType_txt,//文本
    QRType_http,//网址
    QRType_app,//app
    QRType_wifi,//wifi
    QRType_mail,//邮箱
    QRType_card//名片
};
