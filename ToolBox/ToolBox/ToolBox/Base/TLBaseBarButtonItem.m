//
//  IZCBarButtonItem.m
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/28.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import "TLBaseBarButtonItem.h"
#import "TLStringKit.h"

@interface TLBaseBarButtonItem ()
{
}

@property(nonatomic, strong) UIButton *customButton;
@property(nonatomic, strong) UIImage *customImage;
@property(nonatomic, strong) UIImage *customSelectedImage;
@property(nonatomic, strong) UIView *itemCustomView;

@end

@implementation TLBaseBarButtonItem

- (void)dealloc
{
    _customImage = nil;
    _customButton = nil;
    _customSelectedImage = nil;
    _itemCustomView = nil;
}

- (id)initWithCustomImage:(UIImage *)image
            selectedImage:(UIImage *)selectedImage
                   target:(id)target
                   action:(SEL)action
                 leftItem:(BOOL)leftItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0.0f, 0.0f, 22.5, 22.5)];
    btn.layer.cornerRadius = 10;
//    [btn setFrame:CGRectMake(0.0f, 0.0f, 32, 32)];
//    btn.layer.cornerRadius = 16;
    btn.clipsToBounds = YES;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [DevGetColorFromRGB(197, 225, 250) CGColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (image)
    {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage)
    {
        [btn setImage:selectedImage forState:UIControlStateHighlighted];
    }
    /* Init method inherited from UIBarButtonItem */
    self = [[TLBaseBarButtonItem alloc] initWithCustomView:btn];
    if (self)
    {
        /* Assign ivars */
        self.customImage = image;
        self.customSelectedImage = selectedImage;
    }
    
    return self;
}

//end
- (id)initWithImage:(UIImage *)image
      selectedImage:(UIImage *)selectedImage
             target:(id)target
             action:(SEL)action
           leftItem:(BOOL)leftItem
{
    if (nil == image) {
        return nil;
    }
    //wqq-ios11 点控区域变小，修改按钮的大小，图片居中靠左显示
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn setFrame:CGRectMake(0.0f, 0.0f, 60, 44)];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (image)
    {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage)
    {
        [btn setImage:selectedImage forState:UIControlStateHighlighted];
    }
    //靠左
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //居中
    btn.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    /* Init method inherited from UIBarButtonItem */
    self = [[TLBaseBarButtonItem alloc] initWithCustomView:btn];
    
    if (self)
    {
        /* Assign ivars */
        self.customImage = image;
        self.customSelectedImage = selectedImage;
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)title
             target:(id)target
             action:(SEL)action
           leftItem:(BOOL)leftItem
{
    UIFont *titleFont = DevSystemFontOfSize(15);
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    titleButton.backgroundColor = [UIColor yellowColor];   //test
    CGFloat titleWidth = [TLStringKit getStringProperSize:title font:titleFont].width;
    if (titleWidth < 35)
    {
        titleWidth = 35;
    }
    [titleButton setFrame:CGRectMake(0.0f, 0.0f, titleWidth, 30)];
//    [titleButton setTitleColor:DevGetColorFromHex(0xffffff)
//                      forState:UIControlStateNormal];
    [titleButton setTitleColor:DYNavTitleColor
                      forState:UIControlStateNormal];
    [titleButton setTitle:title
                 forState:UIControlStateNormal];
    [titleButton addTarget:target
                    action:action
          forControlEvents:UIControlEventTouchUpInside];
    titleButton.titleLabel.font = titleFont;   //rachel changed
    
    self = [[TLBaseBarButtonItem alloc] initWithCustomView:titleButton];
    if (self)
    {
        
    }
    return self;
}

+ (TLBaseBarButtonItem *)barItemWithImage:(UIImage*)image
                        selectedImage:(UIImage*)selectedImage
                               target:(id)target
                               action:(SEL)action leftItem:(BOOL)leftItem
{
    @autoreleasepool {
        return [[TLBaseBarButtonItem alloc] initWithImage:image
                                         selectedImage:selectedImage
                                                target:target
                                                action:action
                                              leftItem:leftItem];
    }
}

+ (TLBaseBarButtonItem *)barItemWithTitle:(NSString *)title
                               target:(id)target
                               action:(SEL)action
                             leftItem:(BOOL)leftItem
{
    return [[TLBaseBarButtonItem alloc] initWithTitle:title
                                            target:target
                                            action:action
                                          leftItem:leftItem];
}

+ (TLBaseBarButtonItem *)barItemWithCustomView:(UIView *)customView{
    @autoreleasepool {
        TLBaseBarButtonItem *barButtonView = [[TLBaseBarButtonItem alloc] initWithCustomView:customView];
        if (customView){
            barButtonView.itemCustomView = customView;
        }
        return barButtonView;
    }
}

- (void)setCustomImage:(UIImage *)image
{
    _customImage = image;
    [self.customButton setImage:image forState:UIControlStateNormal];
}

- (void)setCustomSelectedImage:(UIImage *)image
{
    _customSelectedImage = image;
    [self.customButton setImage:image forState:UIControlStateHighlighted];
}

@end
