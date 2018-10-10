//
//  QRSettingMenuCollectionView.h
//  ToolBox
//
//  Created by wqq on 2018/9/9.
//  Copyright © 2018年 DOUBLE Q. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBQRModel.h"

enum CollectionType : NSInteger{
    CollectionType_qrMenu, // 二维码菜单设置选项
    CollectionType_qrColor, // 二维码颜色选择设置
};

typedef void (^ItmeActionBlock)(NSInteger index,TBQRModel *model);//二维码设置的block
typedef void (^ColorSelectBlock)(NSInteger index,UIColor *color);//颜色选择的block

@interface QRSettingMenuCollectionView : UIView
//二维码设置菜单选项
@property (assign, nonatomic)CGFloat iconWidth;
@property (assign, nonatomic)CGFloat iconHeight;
@property (assign, nonatomic)CGFloat titleFont;
@property (assign, nonatomic)CGFloat iconTitleSpace;
@property (strong, nonatomic)UIColor *titleColor;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (copy, nonatomic)ItmeActionBlock block;//回调的block
//二维码设置菜单选项

//颜色选项卡的设置
@property (strong, nonatomic)NSMutableArray *colorsArray;
@property (copy, nonatomic)ColorSelectBlock colorBlock;//回调的block

//颜色选项卡的设置



//公共参数
@property (assign, nonatomic)NSInteger rowItemCount;//每行最多显示几个
@property (assign, nonatomic)enum CollectionType collectionType;
@end
