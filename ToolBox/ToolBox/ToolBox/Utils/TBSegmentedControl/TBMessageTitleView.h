//
//  DYMessageTitleView.h
//  DYGameCenter
//
//  Created by DOUBLE Q on 2017/12/22.
//  Copyright © 2017年 devstore. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectActionBlock)(NSInteger index);

@interface TBMessageTitleView : UIView

//设置显示titleview的显示样式
-(void)setTitle:(NSArray *)array selectBloclk:(SelectActionBlock)block;

//外部需要刷新选择的index,点击推送消息后，会跳到消息制定的模块，此时需要刷新下当前选中状态
-(void)setMarkViewIndex:(NSInteger)index;



/**
 红点的显示和隐藏

 @param isShow 是否显示
 @param index 索引
 */
- (void)showRedpointAtIndex:(BOOL)isShow index:(NSInteger)index;

/** 显示红点数 */
//- (void)updateMessageNumber:(NSInteger)count index:(NSInteger)index;


@end
