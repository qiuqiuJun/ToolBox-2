//
//  IZCNavigationController.m
//  DevTongXie
//
//  Created by Steven on 15/5/24.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import "TLBaseNavigationController.h"
#import "TLBaseViewController.h"
#import "TLBaseBarButtonItem.h"
#pragma mark -
@implementation UINavigationItem (DYItemExcursion)

/**
 *  @brief 以下的扩展是为了解决ios7以上系统，自定义的BarButtonItem的偏移问题
 */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >=  __IPHONE_7_0
- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{
    if (_leftBarButtonItem)
    {
        BOOL isIZCBarButtonItem = ([[_leftBarButtonItem class] isSubclassOfClass:[TLBaseBarButtonItem class]]);
        if (isIZCBarButtonItem)
        {// 只给IZCBarButtonItem调整偏移
            [self setDYLeftBarButtonItems:@[_leftBarButtonItem]];
        }
        else
        {
            [self setLeftBarButtonItem:_leftBarButtonItem animated:NO];
        }
    }
}
/**
 *  @brief 调整左侧barButtonItem的偏移
 *
 *  @param leftBarButtonItems barButtonItems
 */
- (void)setDYLeftBarButtonItems:(NSArray *)leftBarButtonItems
{
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    if(Dev_IOS_7_0)
    {
        UIBarButtonItem *leftBarButtonItem = leftBarButtonItems[0];
        
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                           target:leftBarButtonItem.target
                                                                                           action:leftBarButtonItem.action];
        negativeSeperator.width = -2;
        
        NSMutableArray *barItems = [NSMutableArray arrayWithObject:negativeSeperator];
        [barItems addObjectsFromArray:leftBarButtonItems];
        
        [self setLeftBarButtonItems:barItems];
    }
    else
    {
        if (Dev_IOS_5_0)
        {
            [self setLeftBarButtonItems:leftBarButtonItems
                               animated:NO];
        }
        else
        {// 4.3 -- 这里的写法只是为了让软件不崩溃
            [self setLeftBarButtonItem:leftBarButtonItems[0] animated:NO];
        }
    }
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    if (rightBarButtonItem)
    {
        BOOL isIZCBarButtonItem = ([[rightBarButtonItem class] isSubclassOfClass:[TLBaseBarButtonItem class]]);
        if (isIZCBarButtonItem)
        {// 只给IZCBarButtonItem调整偏移
            [self setDYRightBarButtonItems:@[rightBarButtonItem]];
        }
        else
        {
            [self setRightBarButtonItem:rightBarButtonItem animated:NO];
        }
    }
}
/**
 *  @brief 调整右侧BarButtonItem的偏移
 *
 *  @param rightBarButtonItems 右侧的BarButtonItem
 */
- (void)setDYRightBarButtonItems:(NSArray *)rightBarButtonItems
{
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -2;
    
    NSMutableArray *barItems = [NSMutableArray arrayWithObject:negativeSeperator];
    [barItems addObjectsFromArray:rightBarButtonItems];
    
    [self setRightBarButtonItems:barItems];
}

#endif

@end

#pragma mark -
@interface TLBaseNavigationController ()
<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController *currentShowController;

// 创建的时候是不是横屏
@property (nonatomic, assign) BOOL initIsLandspace;
//@property (nonatomic, strong) NSMutableArray *screenArray;
//@property (nonatomic, strong) DyScreeningView *screeningView;
@end

@implementation TLBaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
        if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]))
        {
            self.initIsLandspace = YES;
        }
        else
        {
            self.initIsLandspace = NO;
        }
    }
    return self;
}

- (void)dealloc
{
//    DYLog(@"IZCNavigationController dealloc");
}

- (void)customNavigationBar
{
    // 定制导航条背景样式
    UIColor *navBarColor = DYNavColor;
    [self.navigationBar setBarTintColor:navBarColor];
    //标题
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    DYNavTitleColor, NSForegroundColorAttributeName,
                                    DevSystemFontOfSize(18), NSFontAttributeName, nil];
    
    [self.navigationBar setTitleTextAttributes:textAttributes];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        __unsafe_unretained TLBaseNavigationController *weakSelf = self;
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        
        self.delegate = weakSelf;
    }
    
    //self.navigationBar.barTintColor = [UIColor whiteColor];不能设置，设置之后导致不透明
    // 背景
    [self customNavigationBar];
    
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (TLBaseBarButtonItem *)createBackButton
{
    TLBaseBarButtonItem *backItem =
    [TLBaseBarButtonItem barItemWithImage:[UIImage imageNamed:@"DYGameCenter.bundle/nav/navBack_black"]
                          selectedImage:[UIImage imageNamed:@"DYGameCenter.bundle/nav/navBack_black"]
                                 target:self
                                 action:@selector(navBackItemClick) leftItem:YES];
    return backItem;
}


- (void)navBackItemClick
{
    UIViewController *currentVC = self.topViewController;
    if ([currentVC isKindOfClass:[TLBaseViewController class]])
    {
        if ([(TLBaseViewController *)currentVC backEnable])
        {
            [self popViewControllerAnimated:YES];
        }
    } else {
        [self popViewControllerAnimated:YES];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch
{
    //如果在红色方框内有长按手势，这里需要快速返回NO，要不然反映会很迟钝。
    //处理聊天初始化录音时卡
    return YES;
}
//

//
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
//    DYLog(@"gestureRecognizerShouldBegin....");
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        if (gestureRecognizer == self.interactivePopGestureRecognizer)
        {
            TLBaseViewController *currentVC = (TLBaseViewController *)self.topViewController;
            if (self.viewControllers.count == 1)
            {//关闭主界面的右滑返回-解决主界面右滑后触发导航动作之后，软件假死，动画失效的情况
                return NO;
            }
            else if ([currentVC isKindOfClass:[TLBaseViewController class]])
            {
                if (currentVC.panGestureDisable || [(TLBaseViewController *)currentVC rightSwipeBackDisable]) {
                     return NO;
                }else {
                    return YES;
                }
               
            }
            else
            {
                return YES;
            }
        }
    }

    return NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    
    // 对tabbar进行处理
    if ([self.viewControllers count]==1)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1)
    {
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    }
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    NSArray *viewControllers = navigationController.viewControllers;
    // 最后一个判断是排除这里不能是push操作
    if ([viewControllers count]==1)
    {// 这里是一个特殊情况
        if (self.currentShowController != viewController) {
            if ([self.currentShowController isKindOfClass:[TLBaseViewController class]]) {
                // 这里只是一个通知操作
                [self.currentShowController performSelectorOnMainThread:@selector(viewControllerWillReturn) withObject:nil waitUntilDone:YES];
            }
        }
    }
    else
    {// 都是大于1的情况
        if (self.currentShowController != viewController && self.currentShowController!=viewControllers[viewControllers.count-2]) {
            if ([self.currentShowController isKindOfClass:[TLBaseViewController class]]) {
                // 这里只是一个通知操作
                [self.currentShowController performSelectorOnMainThread:@selector(viewControllerWillReturn) withObject:nil waitUntilDone:YES];
            }
        }
    }
    
    self.currentShowController = navigationController.topViewController;
    
//    DYLog(@"self.currentShowController:%@", self.currentShowController);
//    DYLog(@"navigationController didShowViewController %@ --- \n %@", viewController, self.currentShowController);
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        TLBaseViewController *vc = (TLBaseViewController *)viewController;
        
        if ([vc isKindOfClass:[TLBaseViewController class]] && vc.panGestureDisable) {
            self.interactivePopGestureRecognizer.enabled = NO;
        } else {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}


//#pragma mark - StatusBar
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
//
//- (BOOL)prefersStatusBarHidden
//{
//    return NO;
//}
#pragma mark - Orientations
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}


- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.topViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return [self.topViewController supportedInterfaceOrientations];
//}
//-(BOOL)shouldAutorotate
//{
//    return YES;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return [self.topViewController preferredInterfaceOrientationForPresentation];
//}

//add by yly - 20180116 - 添加这一句的代码的原因是因为不添加这一句代码，界面左滑导航栏会消失，弊端：每一个界面VC都需要增加一句单独的改变状态栏颜色的代码
//- (UIViewController *)childViewControllerForStatusBarStyle{
//    return self.visibleViewController;
//}

@end
