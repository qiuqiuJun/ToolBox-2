//
//  DYMessageTitleView.m
//  DYGameCenter
//
//  Created by DOUBLE Q on 2017/12/22.
//  Copyright © 2017年 devstore. All rights reserved.
//

#import "TBMessageTitleView.h"
#import "Masonry.h"
#import "TLMacroUtility.h"
//#import "UIView+YYAdd.h"
//#import "DYThemeDefine.h"
#define markViewTag 100
#define titleTag 200
#define TitleSelectClor DYThemeColor
#define TitleUnSelectClor DevGetColorFromHex(0x333333)

@interface TBMessageTitleView()

@property (nonatomic,strong)NSMutableArray *controlArray;   //保存实例的control对象
@property (nonatomic,strong)NSMutableArray *redpointArr;    //保存红点实例对象
@property (nonatomic,strong)UIControl *selectControl;  //保存被选择的视图（用于还原不被选择时的设置）
@property (nonatomic,copy)  SelectActionBlock block;


@end


@implementation TBMessageTitleView

- (void)dealloc{
    
    self.controlArray = nil;
    self.selectControl = nil;
    self.block = nil;
    self.redpointArr = nil;
}

-(void)setTitle:(NSArray *)array selectBloclk:(SelectActionBlock)block{

    if (!array || array.count == 0) return;
    
    if (block) self.block = block;
    
    CGFloat buttonWidth = self.bounds.size.width/array.count;
    if (!self.redpointArr) {
        self.redpointArr = [NSMutableArray array];//[NSMutableArray arrayWithCapacity:0]; //可以用懒加载方法实现
    }
    [self.redpointArr removeAllObjects];
    
    for (NSInteger i = 0; i < array.count; i++) {
        
        UIControl *control = [[UIControl alloc] init];
        control.backgroundColor = [UIColor clearColor];
        [control addTarget:self action:@selector(conAction:) forControlEvents:UIControlEventTouchUpInside];
        control.tag = i;
        [self addSubview:control];
        control.frame = CGRectMake(buttonWidth*i, 0, buttonWidth, self.bounds.size.height);
        if (!self.controlArray) {
            self.controlArray = [NSMutableArray array];//[NSMutableArray arrayWithCapacity:0];
        }
        [self.controlArray addObject:control];
        
        //titile
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor clearColor];
        label.font = DevSystemFontOfSize(18);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [array objectAtIndex:i];
        label.tag = titleTag;
        label.textColor = TitleUnSelectClor;
        label.frame = CGRectMake(0, 0, buttonWidth, 38);
        [control addSubview:label];
        
        //新消息标记
        UIView *redPoint = [[UIView alloc] init];
        redPoint.backgroundColor = TitleSelectClor;
        redPoint.frame = CGRectMake(buttonWidth - 20, 5, 10, 10);
        redPoint.layer.cornerRadius = 5.0;
        redPoint.layer.borderColor = DevGetColorFromHex(0xffffff).CGColor;
        redPoint.layer.borderWidth = 1.0;
        
//        redPoint.tag = redPointTag;
        
        // 显示红点数
//        UILabel *numberLabel  = [[UILabel alloc] init];
//        numberLabel.backgroundColor = DevGetColorFromHex(0xf23730);
//        numberLabel.layer.masksToBounds = YES;
//        numberLabel.layer.cornerRadius = 5;
//        numberLabel.textAlignment = NSTextAlignmentCenter;
//        numberLabel.textColor = [UIColor whiteColor];
//        numberLabel.font = DevSystemFontOfSize(12);
//        numberLabel.tag = redPointLabelTag;
//        [redPoint addSubview:numberLabel];
        
        [control addSubview:redPoint];
        redPoint.hidden = YES;
        [self.redpointArr addObject:redPoint];
    }
    //选中标志
    UIView *markView = [UIView new];
    markView.backgroundColor = TitleSelectClor;
    markView.layer.cornerRadius = 1.5;
    markView.layer.masksToBounds = YES;
    markView.tag  = markViewTag;
    [self addSubview:markView];
    UIControl *firstContro = [self.controlArray objectAtIndex:0];
    markView.frame = CGRectMake((buttonWidth - 16)*0.5 + firstContro.bounds.origin.x, CGRectGetMaxY(firstContro.frame), 16, 3);
//    [self layoutIfNeeded];//如果其约束还没有生成的时候需要动画的话，就请先强制刷新后才写动画，否则所有没生成的约束会直接跑动画
//    [self conAction:[self.controlArray objectAtIndex:0]];
    [self conAction:self.controlArray.firstObject];
}


- (void)conAction:(UIControl *)sender{
    [self selectIndex:sender.tag];
}

//选中的title有改变时，修改titleView选中ui样式
- (void)selectIndex:(NSInteger)index{
    
    //选中标记的view
    UIView *markView = [self viewWithTag:markViewTag];
    //当前选中的control
    UIControl *control = [self.controlArray objectAtIndex:index];
    //当前选中的标题
    UILabel *title = (UILabel *)[control viewWithTag:titleTag];
    if (markView) {
        [UIView animateWithDuration:0.5 animations:^{//选择视图滑动动画
            markView.frame = CGRectMake((CGRectGetWidth(control.frame) - 16)*0.5 + CGRectGetMinX(control.frame), CGRectGetMaxY(control.frame), 16, 3);
        } completion:^(BOOL finished) {

        }];
    }
    if (control && title) {
        //改变当前的标题的颜色
        title.textColor = TitleSelectClor;
        //改变上一个标题的颜色
        if (self.selectControl) {
            UILabel *lastTitle = (UILabel *)[self.selectControl viewWithTag:titleTag];
            lastTitle.textColor = TitleUnSelectClor;
        }
    }
    self.selectControl = control;
    //block回调
    if (self.block) {
        self.block(index);
    }
}

//设置消息列表标题视图的选择显示序号
-(void)setMarkViewIndex:(NSInteger)index{
    
    //选中标记的view
    UIView *markView = [self viewWithTag:markViewTag];
    //当前选中的control
    UIControl *control = [self.controlArray objectAtIndex:index];
    //当前选中的标题
    UILabel *title = (UILabel *)[control viewWithTag:titleTag];
    if (markView) {//选择视图滑动动画
        [UIView animateWithDuration:0.5
                         animations:^{
                             
            markView.frame = CGRectMake((CGRectGetWidth(control.frame) - 16) * 0.5 + CGRectGetMinX(control.frame), CGRectGetMaxY(control.frame), 16, 3);
        } completion:^(BOOL finished) {}];
    }
    
    if (control && title) {
        //改变当前的标题的颜色
        title.textColor = TitleSelectClor;
        //改变上一个标题的颜色
        if (self.selectControl) {
            UILabel *lastTitle = (UILabel *)[self.selectControl viewWithTag:titleTag];
            lastTitle.textColor = TitleUnSelectClor;
        }
    }
    
    self.selectControl = control;
}

/**
 红点的显示和隐藏
 
 @param isShow 是否显示
 @param index 索引
 */
- (void)showRedpointAtIndex:(BOOL)isShow index:(NSInteger)index{
    
    if (self.redpointArr && self.redpointArr.count >= index + 1) {
//        UIView *redpointView = [self.redpointArr objectAtIndex:index];
        UIView *redpointView = self.redpointArr[index];
        if (redpointView) {
            redpointView.hidden = !isShow;
        }
    }
}
@end
