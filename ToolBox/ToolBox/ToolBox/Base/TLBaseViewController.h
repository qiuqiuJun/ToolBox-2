//
//  IZCBaseViewController.h
//  DevTongXie
//
//  Created by 球球君 on 15/5/19.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLBaseNavigationController.h"
#import "TLBaseBarButtonItem.h"
#import "TLBaseTableViewCell.h"
#import "Masonry.h"
#define DYDeviceRotateToVerticalNotification @"DYDeviceRotateToVertical"
#define DYDeviceRotateToHorizontalNotification @"DYDeviceRotateToHorizontal"
#define DYDeviceDidRotateNotification @"DYDeviceDidRotate"
#define kBackgroundColor DevGetColorFromRGB(238, 238,   238)
#define kIZCNavigationColor DevGetColorFromRGB(51, 160, 254)
#define kIZCGrayColor DevGetColorFromRGB(204, 204, 204)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphoneXBottonSafeHeight 34

@interface TLBaseViewController : UIViewController

// 暂时先加在这里，合并圈子举报之后，放到圈子基类里面去
@property (nonatomic, assign) NSInteger childIndex;
/*
 如果当前页面要屏蔽掉滑动返回，将这个BOOL值设为YES;
 记得恢复状态
 */
@property(nonatomic, assign) BOOL panGestureDisable;

//获取buttonItem
+ (UIBarButtonItem *)getBarButtonItem:(UIImage *)image hImage:(UIImage *)hImage target:(id)target action:(SEL)action;

//默认title，title为温馨提示
- (void)showAlertViewWithMessage:(NSString *)content tag:(NSInteger)tag;

//自定义title、确定和取消两个按钮
- (void)showAlertViewSetTitle:(NSString *)title andWithContent:(NSString *)content tag:(NSInteger)tag;

//自定义title只有一个确定按钮
- (void)showAlertViewOneButtonSetTitle:(NSString *)title andWithContent:(NSString *)content andWithTag:(NSInteger)tag;

//自定义标题和内容
- (void)showAlertViewWithTitle:(NSString *)title content:(NSString *)content;

// 这个方法是提供给自定义Nav调用的，任何人不要手动调用这个方法
- (void)setDevNavBarLeftItem;   //设置左返回

// 手动调用，相当于用户点击了导航栏的左上角 -- 这里的方法会检查backEnable是否允许返回
- (void)navBarLeftItemClick;


// 20160418 - 增加返回操作的处理
/**
 *  需要特殊处理的IZCBaseViewController的子类重写这个方法，按需要情况设置是否允许返回
 *
 *  @return YES:允许页面返回；NO:页面的返回操作将不会执行
 */
- (BOOL)backEnable;

/*!
 *  @brief 按需要情况设置是否不允许侧滑返回
 *
 *  @return YES:不允许页面返回；NO:允许
 */
- (BOOL)rightSwipeBackDisable;

/**
 * 返回的Item点击了
 *  这个viewControllerWillReturn中你不需要再写返回操作，这里只是通知你界面要返回了
 *  注意方法中不要出现耗时操作，如果重写了
 *  除导航栈中的第一个控制器以外，其它的控制器都可以接收到该方法的回调
 */
- (void)viewControllerWillReturn;
/**
 *  当ViewController是右滑返回的时候会回调这个方法
 */
//- (void)viewControllerRightSlideBack;
/**
 * 强制返回操作-不去检查backEnable的返回值
 */
- (void)forceBack;

/**
 * tabbar二次点击的时候，触发事件的方法
 * 实现了此方法，就会调用
 */
- (void)tabBarSelectAction;

- (void)toLoginVC;
//初始化view的方法，子类实现
- (void)dyBasicView;
//初始化data的方法，子类实现
- (void)dyBasicData;

/**
 个别页面需要单独处理自己的导航栏主题
 白色主题，黑色title，黑色的返回按钮
 */
- (void)customNavWhite;

/**
 自定义白色返回箭头
 */
- (void)customNavWhiteBack;
/**
 个别页面需要单独处理自己的导航栏主题
 红色主题，白色title，白色的返回按钮
 */
- (void)customNavRed;
/**
 自定义黑色返回箭头
 */
- (void)customNavBlackBack;
@end

