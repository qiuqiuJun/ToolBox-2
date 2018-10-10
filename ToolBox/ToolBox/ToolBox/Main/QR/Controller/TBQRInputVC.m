//
//  TBQRInputVC.m
//  ToolBox
//
//  Created by wqq on 2018/9/9.
//  Copyright © 2018年 DOUBLE Q. All rights reserved.
//

#import "TBQRInputVC.h"
#import "QRAddCell.h"
#import "ToolBox-Swift.h"
@interface TBQRInputVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (strong, nonatomic) UITableView *tabview;
@property (strong, nonatomic) UITextView *inputView;
@property (strong, nonatomic) NSString *inputSring;

@end

@implementation TBQRInputVC
- (void)dealloc{
//    [self.inputView removeObserver:self forKeyPath:@"text"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)dyBasicData{
    
}
- (void)dyBasicView{
    DYWeakSelf;
    self.view.backgroundColor = DevGetColorFromHex(0xf1f1f1);
    [self.view addSubview:self.tabview];
    if (@available(iOS 10.0,*)) {
        self.tabview.estimatedRowHeight = 0;
        self.tabview.estimatedSectionFooterHeight = 0;
        self.tabview.estimatedSectionHeaderHeight = 0;
    }
    [self.tabview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakSelf.view);
    }];
    
    switch (self.qrType) {
        case QRType_txt:
        {
            self.title = @"文本";
        }
            break;
        case QRType_mail:
        {
            self.title = @"邮箱";
        }
            break;
        case QRType_http:
        {
            self.title = @"网址";
        }
            break;
        case QRType_app:
        {
            self.title = @"App";
        }
        case QRType_wifi:
        {
            self.title = @"WIFI";
        }
        case QRType_card:
        {
            self.title = @"名片";
        }
            break;
            break;
        default:
            break;
    }
}
#pragma -mark lazy
- (UITableView *)tabview{
    if (nil == _tabview) {
        _tabview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tabview.backgroundColor = [UIColor clearColor];
        _tabview.showsVerticalScrollIndicator = NO;
        _tabview.delegate = self;
        _tabview.dataSource = self;
        _tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tabview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tabview registerClass:[QRAddCell class] forCellReuseIdentifier:NSStringFromClass([QRAddCell class])];

    }
    return _tabview;
}
#pragma -mark UITableView - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 60;//广告
    }
    switch (self.qrType) {
        case QRType_card:
            return 1;
            break;
        case QRType_txt:
            return 280 + 60;
            break;
        case QRType_http:
            return 1;
            break;
        case QRType_mail:
            return 1;
            break;
        case QRType_app:
            return 1;
            break;
        case QRType_wifi:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        //广告
        return 1;
    }
    switch (self.qrType) {
        case QRType_card:
            return 1;
            break;
        case QRType_txt:
            return 1;
            break;
        case QRType_http:
            return 1;
            break;
        case QRType_mail:
            return 1;
            break;
        case QRType_app:
            return 1;
            break;
        case QRType_wifi:
            return 1;
            break;
            
        default:
            return 1;
            break;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        QRAddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QRAddCell class]) forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        UIView *gg = [cell viewWithTag:100];
        if (!gg) {
            gg.backgroundColor = [UIColor redColor];
            gg.tag = 100;
            [cell addSubview:gg];
            [gg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell).offset(15);
                make.right.equalTo(cell).offset(-15);
                make.centerY.equalTo(cell);
                make.height.mas_equalTo(30);
            }];
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];

        switch (self.qrType) {
            case QRType_card:
                break;
            case QRType_mail:
            case QRType_http:
            case QRType_txt:{
                UITextView *textView = (UITextView *)[cell viewWithTag:100];
                if (!textView) {
                    textView = [[UITextView alloc] init];
                    textView.backgroundColor = DevGetColorFromHex(0xffffff);
                    textView.textColor = DevGetColorFromHex(0x656d7a);
                    textView.font  = DevSystemFontOfSize(15);
                    textView.layer.cornerRadius = 5.0;
                    textView.tag = 100;
                    textView.layer.masksToBounds = YES;
                    textView.returnKeyType = UIReturnKeyDone;
                    [cell addSubview:textView];
                    self.inputView = textView;
                    textView.delegate = self;
                    [textView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(cell).offset(15);
                        make.right.equalTo(cell).offset(-15);
                        make.top.equalTo(cell).offset(15);
                        make.height.mas_equalTo(250);
                        
                    }];
                    UIButton *okBtn = (UIButton *)[cell viewWithTag:200];
                    if (!okBtn) {
                        okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        okBtn.backgroundColor = DevGetColorFromHex(0xffffff);
                        okBtn.layer.cornerRadius = 5.0;
                        [okBtn addTarget:self action:@selector(okBtnAction) forControlEvents:UIControlEventTouchUpInside];
                        [okBtn setTitle:@"DIY二维码" forState:UIControlStateNormal];
                        [okBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                        okBtn.titleLabel.font = DevSystemFontOfSize(14);
                        [cell addSubview:okBtn];
                        [okBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(cell).offset(15);
                            make.right.equalTo(cell).offset(-15);
                            make.top.equalTo(textView.mas_bottom).offset(15);
                            make.height.mas_equalTo(45);
                        }];
                    }
                    
                }
            }
                break;
                
            case QRType_app:
                return cell;
                break;
            case QRType_wifi:
                return cell;
                break;
                
            default:
                return cell;
                break;
        }
        return cell;
    }
}

#pragma -mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    self.inputSring = textView.text;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;//这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}
#pragma -mark action
- (void)okBtnAction{
    if (!DevNSStringIsEmpty(self.inputSring)) {
        GeneratorController *gener = [[GeneratorController alloc] init];
        gener.qrContent = self.inputSring;
        [self.navigationController pushViewController:gener animated:YES];
    }else{
        NSLog(@"请输入内容");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
