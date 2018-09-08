//
//  DYSwiftDefine.swift
//  DYGameCenter
//
//  Created by DOUBLEQ on 2018/8/25.
//  Copyright © 2018年 devstore. All rights reserved.
//

import Foundation
//value 是AnyObject类型是因为有可能所传的值不是String类型，有可能是其他任意的类型。
func DYStringIsEmpty(value: AnyObject?) -> Bool {
    //首先判断是否为nil
    if (nil == value) {
        //对象是nil，直接认为是空串了
        return true
    }else{
        //然后是否可以转化为String
        if let myValue  = value as? String{
            //然后对String做判断
            return myValue == "" || myValue == "(null)" || 0 == myValue.count
        }else{
            //不是字符串类型，认为是空串了
            return true
        }
    }
}
func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func BottomHeight() -> Int {
    if (UIScreen.main.bounds.height >= 812) {
        return 88
    }else{
        return 64
    }
}
func StatusBarHeight() -> Int {
    if (UIScreen.main.bounds.height >= 812) {
        return 20 + 24
    }else{
        return 20
    }
}
