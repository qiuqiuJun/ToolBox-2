//
//  ViewController.m
//  ToolBox
//
//  Created by DOUBLEQ on 2018/9/7.
//  Copyright © 2018年 DOUBLE Q. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong ,nonatomic) NSMutableArray *itemArr;
@property (strong ,nonatomic) UITableView *myTab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"万能工具箱";
}

#pragma -mark UI
- (void)dyBasicView{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.myTab];
    [self.myTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakSelf.view);
    }];
}
#pragma -mark -lazy
- (UITableView *)myTab{
    if (!_myTab) {
        _myTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTab.backgroundColor = [UIColor whiteColor];
        _myTab.delegate = self;
        _myTab.dataSource = self;
        [_myTab registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _myTab;
}
- (NSMutableArray *)itemArr{//
    if (nil ==  _itemArr) {
        _itemArr = [[NSMutableArray alloc] initWithObjects:
                    @{@"title":@"二维码扫描",@"className":@"FactoryVC"},
                    @{@"title":@"二维码DIY",@"className":@"TestConstVC"},
                    @{@"title":@"手电筒",@"className":@"WkJsVC"},
                    @{@"title":@"放大镜",@"className":@"ChangeAppIconVC"},
                    @{@"title":@"分贝记",@"className":@"CopyAndMutableCopyVC"},
                    @{@"title":@"指南针",@"className":@"TestYYkitVC"},
                    @{@"title":@"坐标",@"className":@"YYImageTestVC"},
                    @{@"title":@"尺子",@"className":@"GCDController"},
                    @{@"title":@"跑马灯",@"className":@"QRViewController"},
                    @{@"title":@"私密文件",@"className":@"QRViewController"},
                    nil];
    }
    return _itemArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    NSDictionary *dic = (NSDictionary *)self.itemArr[indexPath.row];
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        cell.textLabel.text = dic[@"title"];

    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.itemArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = (NSDictionary *)[self.itemArr objectAtIndex:indexPath.row];
    NSString *className = dic[@"className"];
    UIViewController *con = [(UIViewController *)[NSClassFromString(className) alloc] init];
    [self.navigationController pushViewController:con animated:YES];
}
@end
