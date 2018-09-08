//
//  DYSegmentedControl.h
//  DYDemo
//
//  Created by ios on 2018/4/28.
//  Copyright © 2018年 devstore. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, DYSegmentedControlSegmentWidthStyle) {
//    DYSegmentedControlSegmentWidthStyleContentFit, // content width equal divide， Note：few items
//    DYSegmentedControlSegmentWidthStyleFixed, // Segment width is fixed
//    DYSegmentedControlSegmentWidthStyleDynamic, // Segment width will only be as big as the text width
//};
enum DYSegmentedControlSegmentWidthStyle : NSInteger{
    DYSegmentedControlSegmentWidthStyleContentFit, // content width equal divide， Note：few items
    DYSegmentedControlSegmentWidthStyleFixed, // Segment width is fixed
    DYSegmentedControlSegmentWidthStyleDynamic, // Segment width will only be as big as the text width
};

@protocol DYSegmentedControlDelegate;

@interface TBSegmentedControl : UIView

@property (nonatomic, copy) NSArray<NSString *> *sectionTitles;
@property (nonatomic, weak) id<DYSegmentedControlDelegate> delegate;

/**
 Specifies the style of the segment's width.
 
 Default is `DYSegmentedControlSegmentWidthStyleFixed`
 */
@property (nonatomic, assign) enum DYSegmentedControlSegmentWidthStyle segmentWidthStyle;

/**
 Index of the currently selected segment.
 */
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

/**
 Text attributes to apply to item title text.
 */
@property (nonatomic, strong) NSDictionary *titleTextAttributes;

/**
 Text attributes to apply to selected item title text.
 
 Attributes not set in this dictionary are inherited from `titleTextAttributes`.
 */
@property (nonatomic, strong) NSDictionary *selectedTitleTextAttributes;

@property (nonatomic, strong) UIColor *selectionIndicatorColor;
/**
 Inset left and right edges of segments.
 
 Default is UIEdgeInsetsMake(0, 5, 0, 5)
 */
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset;

/**
 init

 @param frame frame
 @param segmentWidthStyle segment宽度样式
 @param segmentEdgeInset segment边距（主要设置左右边距用）
 @param selectionIndicatorSize 底部指示器size
 @param titleTextAttributes normal状态的文字属性
 @param selectedTitleTextAttributes selected状态的文字属性
 @return DYSegmentedControl
 */
- (instancetype)initWithFrame:(CGRect)frame segmentWidthStyle:(enum DYSegmentedControlSegmentWidthStyle)segmentWidthStyle segmentEdgeInset:(UIEdgeInsets)segmentEdgeInset  selectionIndicatorSize:(CGSize)selectionIndicatorSize titleTextAttributes:(NSDictionary *)titleTextAttributes selectedTitleTextAttributes:(NSDictionary *)selectedTitleTextAttributes;

/// 设置段选位置
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;

/// 设置小红点
//- (void)setRedDotForSegmentIndex:(NSUInteger)index;
//
///// 设置小红点数
//- (void)setBadgeForSegmentIndex:(NSUInteger)index badgeCount:(NSInteger)count;
//
///// 清除小红点
//- (void)clearBadgeForSegmentIndex:(NSUInteger)index;

@end

@protocol DYSegmentedControlDelegate <NSObject>
- (void)segmentedControl:(TBSegmentedControl *)segmentedControl indexChanged:(NSInteger)index;
@end
