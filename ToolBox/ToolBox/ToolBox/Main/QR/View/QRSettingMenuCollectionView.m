//
//  QRSettingMenuCollectionView.m
//  ToolBox
//
//  Created by wqq on 2018/9/9.
//  Copyright © 2018年 DOUBLE Q. All rights reserved.
//

#import "QRSettingMenuCollectionView.h"
#import "TBBaseUICollectionView.h"
#import "TBQRModel.h"
#import "Masonry.h"
#import "TLMacroUtility.h"
@interface QRSettingMenuCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic)TBBaseUICollectionView *menuCollection;
@property (strong, nonatomic)NSMutableArray *myDataArr;
@end

@implementation QRSettingMenuCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.myDataArr = [NSMutableArray arrayWithCapacity:0];
        [self addSubview:self.menuCollection];
        __weak typeof(self) weakSelf = self;
        [self.menuCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(weakSelf);
        }];
    }
    return self;
}
- (void)setDataArray:(NSMutableArray *)dataArray{
    [self.myDataArr removeAllObjects];
    if (dataArray) {
        [self.myDataArr addObjectsFromArray:dataArray];
    }
    [self.menuCollection reloadData];
}
#pragma -mark lazy

- (UICollectionView *)menuCollection{
    if (nil == _menuCollection) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout alloc];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _menuCollection = [[TBBaseUICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _menuCollection.delegate = self;
        _menuCollection.dataSource = self;
        _menuCollection.backgroundColor = [UIColor clearColor];
        [_menuCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    return _menuCollection;
}
#pragma -mark UICollectionViewDelegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    switch (self.collectionType) {
        case CollectionType_qrMenu:{
            UIImageView *icon = (UIImageView *)[cell viewWithTag:100];
            if (!icon) {
                icon = [[UIImageView alloc] init];
                icon.backgroundColor = [UIColor clearColor];
                icon.tag = 100;
                icon.contentMode = UIViewContentModeScaleAspectFit;
                [cell addSubview:icon];
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(cell);
                    make.bottom.equalTo(cell.mas_centerY).offset(0);
                    make.width.mas_equalTo(self.iconWidth);
                    make.height.mas_equalTo(self.iconHeight);
                    
                }];
            }
            UILabel *title = (UILabel *)[cell viewWithTag:200];
            if (!title) {
                title = [[UILabel alloc] init];
                title.backgroundColor = [UIColor clearColor];
                title.font = [UIFont systemFontOfSize:self.titleFont];
                title.textColor = self.titleColor?self.titleColor:DevGetColorFromHex(0x656d7a);
                title.textAlignment = NSTextAlignmentCenter;
                title.numberOfLines = 1;
                title.lineBreakMode = NSLineBreakByTruncatingMiddle;
                title.tag = 200;
                [cell addSubview:title];
                [title mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(icon.mas_bottom).offset(self.iconTitleSpace);
                    make.left.equalTo(cell).offset(10);
                    make.right.equalTo(cell).offset(-10);
                }];
            }
            TBQRModel *model = (TBQRModel *)[self.myDataArr objectAtIndex:indexPath.row];
            if (icon) {
                icon.image = [UIImage imageNamed:model.iconName];
            }
            if (title) {
                title.text = model.title;
            }
        }
            break;
        case CollectionType_qrColor:{
            UIImageView *icon = (UIImageView *)[cell viewWithTag:300];
            if (!icon) {
                CGFloat itemWidth = CGRectGetWidth(self.frame) / (self.rowItemCount > 0 ? self.rowItemCount : 4);

                icon = [[UIImageView alloc] init];
                icon.backgroundColor = [UIColor clearColor];
                icon.tag = 300;
                icon.contentMode = UIViewContentModeScaleAspectFit;
                icon.layer.cornerRadius = (itemWidth-20)*0.5;
                icon.layer.masksToBounds = YES;
                [cell addSubview:icon];
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(cell);
//                    make.bottom.equalTo(cell.mas_centerY).offset(0);
                    make.centerY.equalTo(cell);
                    make.width.mas_equalTo(itemWidth-20);
                    make.height.mas_equalTo(itemWidth-20);
                    
                }];
            }
//            icon.backgroundColor = [UIColor yellowColor];
//            UILabel *title = (UILabel *)[cell viewWithTag:200];
//            if (!title) {
//                title = [[UILabel alloc] init];
//                title.backgroundColor = [UIColor clearColor];
//                title.font = [UIFont systemFontOfSize:self.titleFont];
//                title.textColor = self.titleColor?self.titleColor:DevGetColorFromHex(0x656d7a);
//                title.textAlignment = NSTextAlignmentCenter;
//                title.numberOfLines = 1;
//                title.lineBreakMode = NSLineBreakByTruncatingMiddle;
//                title.tag = 200;
//                [cell addSubview:title];
//                [title mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(icon.mas_bottom).offset(self.iconTitleSpace);
//                    make.left.equalTo(cell).offset(10);
//                    make.right.equalTo(cell).offset(-10);
//                }];
//            }
//            TBQRModel *model = (TBQRModel *)[self.myDataArr objectAtIndex:indexPath.row];
//            if (icon) {
//                icon.image = [UIImage imageNamed:model.iconName];
//            }
//            if (title) {
//                title.text = model.title;
//            }
//            CGFloat itemWidth = CGRectGetWidth(self.frame) / (self.rowItemCount > 0 ? self.rowItemCount : 4);
//            UILabel *colorView = [cell viewWithTag:300];
//            if (!colorView) {
//                colorView = [[UILabel alloc] init];
//                colorView.tag = 300;
//                colorView.textColor = [UIColor blackColor];
//                colorView.font = DevSystemFontOfSize(12);
////                colorView.layer.cornerRadius = (itemWidth-30)*0.5;
////                colorView.layer.masksToBounds = YES;
//                [cell addSubview:colorView];
//                [cell mas_makeConstraints:^(MASConstraintMaker *make) {
////                    make.centerX.equalTo(cell);
////                    make.centerY.equalTo(cell);
////                    make.width.mas_equalTo(itemWidth-30);
////                    make.height.mas_equalTo(itemWidth-30);
//                    make.left.equalTo(cell).offset(10);
//                    make.right.equalTo(cell).offset(-10);
//                    make.top.equalTo(cell).offset(10);
//                    make.bottom.equalTo(cell).offset(-10);
//
//                }];
//            }
            UIColor *qrColor = (UIColor *)[self.myDataArr objectAtIndex:indexPath.row];
            if (qrColor && [qrColor isKindOfClass:[UIColor class]]) {
                icon.backgroundColor = qrColor;
            }
//            colorView.text = @"1223";
        }
            
            break;
        default:
            break;
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.myDataArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.frame) / (self.rowItemCount > 0 ? self.rowItemCount : 4), CGRectGetHeight(self.frame));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    switch (self.collectionType) {
        case CollectionType_qrMenu:{
            TBQRModel *model = (TBQRModel *)self.myDataArr[indexPath.row];
            if (model && [model isKindOfClass:[TBQRModel class]]) {
                if (self.block) {
                    self.block(indexPath.row, model);
                }
            }
        }
            break;
        case CollectionType_qrColor:{
            UIColor *color = (UIColor *)self.myDataArr[indexPath.row];
            if (color && [color isKindOfClass:[UIColor class]]) {
                if (self.colorBlock) {
                    self.colorBlock(indexPath.row, color);
                }
            }
        }
            break;
        default:
            break;
    }
}
@end
