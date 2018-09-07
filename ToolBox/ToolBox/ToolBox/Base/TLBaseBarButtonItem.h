//
//  IZCBarButtonItem.h
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/28.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMacroUtility.h"
@interface TLBaseBarButtonItem : UIBarButtonItem

+ (TLBaseBarButtonItem *)barItemWithImage:(UIImage*)image
                         selectedImage:(UIImage*)selectedImage
                                target:(id)target
                                action:(SEL)action
                              leftItem:(BOOL)leftItem;


+ (TLBaseBarButtonItem *)barItemWithTitle:(NSString *)title
                               target:(id)target
                               action:(SEL)action
                             leftItem:(BOOL)leftItem;

+ (TLBaseBarButtonItem *)barItemWithCustomView:(UIView *)customView;

- (void)setCustomImage:(UIImage *)image;
- (void)setCustomSelectedImage:(UIImage *)image;

@end
