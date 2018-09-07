//
//  IZCBaseViewController.m
//  DevTongXie
//
//  Created by 球球君 on 15/5/19.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import "TLBaseViewController.h"
#import "TLBaseBarButtonItem.h"
#define kBarButtonDefautHeight (44.0f)

@interface TLBaseViewController ()

@end

@implementation TLBaseViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = DevGetColorFromHex(0xf7f7f7);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self dyBasicData];
    [self dyBasicView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationItem.titleView)
    {
        self.navigationItem.titleView.clipsToBounds = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)customNavWhite{
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    DYNavTitleColor, NSForegroundColorAttributeName,
                                    DevSystemFontOfSize(18), NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    [self.navigationController.navigationBar setBarTintColor:DYNavColor];
}
- (void)customNavWhiteBack{
    TLBaseBarButtonItem *leftBarBtn = [TLBaseBarButtonItem barItemWithImage:[UIImage imageNamed:@"DYGameCenter.bundle/nav/navBack_black"] selectedImage:[UIImage imageNamed:@"DYGameCenter.bundle/nav/navBack_black"] target:self action:@selector(navBarLeftItemClick) leftItem:YES];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}
- (void)customNavRed{
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    DYNavTitleWhiteColor, NSForegroundColorAttributeName,
                                    DevSystemFontOfSize(18), NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    [self.navigationController.navigationBar setBarTintColor:DYThemeColor];
    [self customNavBlackBack];
}
- (void)customNavBlackBack{
    TLBaseBarButtonItem *leftBarBtn = [TLBaseBarButtonItem barItemWithImage:[UIImage imageNamed:@"DYGameCenter.bundle/nav/navBack_white"] selectedImage:[UIImage imageNamed:@"DYGameCenter.bundle/nav/navBack_white"] target:self action:@selector(navBarLeftItemClick) leftItem:YES];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}
// 设置返回按钮-这里只有视图控制器的第一个才会使用该方法设置
-(void)setDevNavBarLeftItem
{
    if (nil == self.navigationItem.leftBarButtonItem)
    {
        TLBaseBarButtonItem *leftBarBtn = [TLBaseBarButtonItem barItemWithImage:[UIImage imageNamed:@"DYGameCenter.bundle/nav/navBack_white.png"] selectedImage:[UIImage imageNamed:@"DYGameCenter.bundle/nav/navBack_white.png"] target:self action:@selector(navBarLeftItemClick) leftItem:YES];
        self.navigationItem.leftBarButtonItem = leftBarBtn;
    }
}

#pragma mark - SDK类型返回
-(void)navBarLeftItemClick
{
    if ([self backEnable])
    {
        [self viewControllerWillReturn];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)backEnable
{
    return YES;
}

- (BOOL)rightSwipeBackDisable
{
    return NO;
}

- (void)viewControllerWillReturn
{
}
//- (void)viewControllerRightSlideBack
//{
//}
- (void)forceBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取导航栏buttonItem
+(UIBarButtonItem *)getBarButtonItem:(UIImage *)image hImage:(UIImage *)hImage target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:hImage forState:UIControlStateHighlighted];
    CGFloat fitWidth = [button sizeThatFits:CGSizeMake(CGFLOAT_MAX, kBarButtonDefautHeight)].width;
    [button setFrame:CGRectMake(0, 0, fitWidth, kBarButtonDefautHeight)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barItem;
}

// 20160425注释
//- (void)addDevDeviceRotateNotification
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DYDeviceRotateToVertical) name:DYDeviceRotateToVerticalNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DYDeviceRotateToHorizontal) name:DYDeviceRotateToHorizontalNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DYDeviceDidRotate) name:DYDeviceDidRotateNotification object:nil];
//}
//- (void)removeDevDeviceRotateNotification
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:DYDeviceRotateToVerticalNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:DYDeviceRotateToHorizontalNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:DYDeviceDidRotateNotification object:nil];
//}
//
//- (void)DYDeviceRotateToVertical
//{}
//- (void)DYDeviceRotateToHorizontal
//{}
//- (void)DYDeviceDidRotate
//{}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}
#pragma mark InterfaceOrientationChanged
//// 6.0
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return interfaceOrientation==UIInterfaceOrientationMaskPortrait||interfaceOrientation==UIInterfaceOrientationMaskPortraitUpsideDown;
//}
//#endif

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
////    DYLog(@"%s shouldAutorotateToInterfaceOrientation", __func__);
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
//    DYLog(@"%s supportedInterfaceOrientations", __func__);
//    return UIInterfaceOrientationMaskAllButUpsideDo wn;
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
//    DYLog(@"%s shouldAutorotate", __func__);
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
//    DYLog(@"%s preferredInterfaceOrientationForPresentation", __func__);
    return UIInterfaceOrientationPortrait;
}

#pragma mark - Other
- (void)showAlertViewWithTitle:(NSString *)title content:(NSString *)content{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert show];
}

- (void)showAlertViewWithMessage:(NSString *)content tag:(NSInteger)tag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.tag = tag;
    [alert show];
}


- (void)showAlertViewSetTitle:(NSString *)title andWithContent:(NSString *)content tag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.tag = tag;
    [alert show];
}

- (void)showAlertViewOneButtonSetTitle:(NSString *)title andWithContent:(NSString *)content andWithTag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alert.tag = tag;
    [alert show];
}

/**
 * tabbar二次点击的时候，触发事件的方法
 * 实现了此方法，就会调用
 */
- (void)tabBarSelectAction
{
//    DYLog(@"子类实现此方法~");
}
- (void)toLoginVC{
//    DYLog(@"子类实现此方法~");
}
//初始化view的方法，子类实现
- (void)dyBasicView{
//    DYLog(@"子类实现此方法~");
}
//初始化data的方法，子类实现
- (void)dyBasicData{
//    DYLog(@"子类实现此方法~");
}
@end


