//
//  TBBaseUICollectionView.m
//  ToolBox
//
//  Created by wqq on 2018/9/9.
//  Copyright © 2018年 DOUBLE Q. All rights reserved.
//

#import "TBBaseUICollectionView.h"

@implementation TBBaseUICollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        if (@available(iOS 10.0,*)) {
        }
    }
    return self;
}

@end
