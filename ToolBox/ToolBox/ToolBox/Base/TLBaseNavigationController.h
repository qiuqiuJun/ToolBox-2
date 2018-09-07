//
//  IZCNavigationController.h
//  DevTongXie
//
//  Created by Steven on 15/5/24.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLThemeDefine.h"
@interface TLBaseNavigationController : UINavigationController

@end


@interface UINavigationItem (DYItemExcursion)
/**
 *  @brief 设置导航栏的多个Item--不能通过重写setLeftBarButtonItems实现，
 *         只能新定义一个方法
 */
- (void)setDYLeftBarButtonItems:(NSArray *)leftBarButtonItems;

- (void)setDYRightBarButtonItems:(NSArray *)rightBarButtonItems;


@end
