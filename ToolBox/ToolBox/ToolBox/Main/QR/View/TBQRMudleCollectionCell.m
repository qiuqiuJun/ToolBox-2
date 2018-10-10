//
//  TBQRMudleCollectionCell.m
//  ToolBox
//
//  Created by wqq on 2018/9/8.
//  Copyright © 2018年 DOUBLE Q. All rights reserved.
//

#import "TBQRMudleCollectionCell.h"
#import "Masonry.h"
#define kIconTag 100
#define kTitleTag 200
@implementation TBQRMudleCollectionCell
- (instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}
- (void)setQrModel:(TBQRModel *)qrModel{
    if (!qrModel || ![qrModel isKindOfClass:[TBQRModel class]]) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    UIImageView *icon = (UIImageView *)[self viewWithTag:kIconTag];
    if (!icon) {
        icon = [[UIImageView alloc] init];
        icon.backgroundColor = [UIColor clearColor];
        icon.tag = kIconTag;
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:icon];
    }
    [icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.width.height.mas_equalTo(50);
    }];
    icon.image = [UIImage imageNamed:qrModel.iconName];

    UILabel *title = (UILabel *)[self viewWithTag:kTitleTag];
    if (!title) {
        title = [[UILabel alloc] init];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = [UIColor grayColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.tag = kTitleTag;
        [self addSubview:title];
    }
    [title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(10);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf).offset(-10);
    }];
    title.text = qrModel.title;

}
@end
