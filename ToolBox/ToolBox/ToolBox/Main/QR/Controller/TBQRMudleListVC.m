//
//  TBQRMudleListVC.m
//  ToolBox
//
//  Created by DOUBLEQ on 2018/9/8.
//  Copyright © 2018年 DOUBLE Q. All rights reserved.
//

#import "TBQRMudleListVC.h"
#import "TBQRMudleCollectionCell.h"
#import "YYKit.h"
#import "TBQRModel.h"
#import "TBQRInputVC.h"

@interface TBQRMudleListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *qrCollection;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) NSArray *arr;
@end

@implementation TBQRMudleListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 10.0,*)) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.qrCollection];
    [self.qrCollection mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(50);
        make.bottom.equalTo(weakSelf.view).offset(-50);
    }];
}
#pragma -mark Data
- (void)dyBasicData{
    [super dyBasicData];
    self.arr = @[@{@"title":@"文本",@"iconName":@"TB.bundle/TB/txt",@"actionIndex":@(QRType_txt)},@{@"title":@"网址",@"iconName":@"TB.bundle/TB/http",@"actionIndex":@(QRType_http)},@{@"title":@"App",@"iconName":@"TB.bundle/TB/app",@"actionIndex":@(QRType_app)},@{@"title":@"WIFI",@"iconName":@"TB.bundle/TB/wifi",@"actionIndex":@(QRType_wifi)},@{@"title":@"邮箱",@"iconName":@"TB.bundle/TB/mail",@"actionIndex":@(QRType_mail)}];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSDictionary *dic in self.arr) {
            TBQRModel *model = [TBQRModel modelWithDictionary:dic];
            if (model) {
                [self.dataArr addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.qrCollection reloadData];
        });
    });
}
#pragma -mark UI
- (void)dyBasicView{
    [super dyBasicView];
}
#pragma -mark lazy
- (NSMutableArray *)dataArr{
    if (nil == _dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
- (UICollectionView *)qrCollection{
    if (nil == _qrCollection) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout alloc];
        _qrCollection = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _qrCollection.delegate = self;
        _qrCollection.dataSource = self;
        _qrCollection.backgroundColor = [UIColor clearColor];
        [_qrCollection registerClass:[TBQRMudleCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([TBQRMudleCollectionCell class])];
    }
    return _qrCollection;
}
#pragma -mark delegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TBQRMudleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TBQRMudleCollectionCell class]) forIndexPath:indexPath];
    cell.qrModel = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame)/3.0, 150);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    TBQRModel *model = (TBQRModel *)[self.dataArr objectAtIndex:indexPath.row];
    if (model && [model isKindOfClass:[TBQRModel class]]) {
        switch (model.actionIndex) {
            case QRType_txt:{
                TBQRInputVC *input = [[TBQRInputVC alloc] init];
                [self.navigationController pushViewController:input animated:YES];
            }
                break;
            case QRType_http:
                
                break;
            case QRType_app:
                
                break;
            case QRType_wifi:
                
                break;
            case QRType_mail:
                
                break;
            default:
                break;
        }
    }
}
@end
