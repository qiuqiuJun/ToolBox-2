//
//  DYSegmentedControl.m
//  DYDemo
//
//  Created by ios on 2018/4/28.
//  Copyright © 2018年 devstore. All rights reserved.
//

#import "TBSegmentedControl.h"
//#import "WZLBadgeImport.h"

#define kDYSegmentedControlBaseTag 10000

@interface TBSegmentedControl ()
@property (nonatomic, assign) CGFloat contentTotalWidth; //只应用于 DYSegmentedControlSegmentWidthStyleScreenFit
@property (nonatomic, assign) CGFloat segmentedControlHeight; //控件高度，提高效率，减少重绘
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CALayer *selectionIndicatorStripLayer; //底部跟随滚动指示器
@property (nonatomic, assign) CGFloat segmentWidth;
@property (nonatomic, assign) CGSize selectionIndicatorSize;//底部指示器的size
@property (nonatomic, copy) NSArray<NSNumber *> *segmentWidthsArray;//各个segment的宽度
@property (nonatomic, strong) UIButton *lastSelectedButton;//记录上次选择的按钮

@end

@implementation TBSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame segmentWidthStyle:(enum DYSegmentedControlSegmentWidthStyle)segmentWidthStyle segmentEdgeInset:(UIEdgeInsets)segmentEdgeInset selectionIndicatorSize:(CGSize)selectionIndicatorSize titleTextAttributes:(NSDictionary *)titleTextAttributes selectedTitleTextAttributes:(NSDictionary *)selectedTitleTextAttributes {
    self = [super initWithFrame:frame];
    if (self) {
        _contentTotalWidth = frame.size.width;
        _segmentedControlHeight = frame.size.height;
        _selectionIndicatorSize = selectionIndicatorSize;
        _segmentWidthStyle = segmentWidthStyle;
        _segmentEdgeInset = segmentEdgeInset;
        _titleTextAttributes = titleTextAttributes;
        _selectedTitleTextAttributes = selectedTitleTextAttributes;
        
        // 默认设置
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.scrollsToTop = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.backgroundColor = [UIColor whiteColor];
    self.opaque = NO;
    _selectionIndicatorColor = [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    
    self.selectedSegmentIndex = 0;
    
    self.selectionIndicatorStripLayer = [CALayer layer];
    self.selectionIndicatorStripLayer.backgroundColor = [_selectedTitleTextAttributes[NSForegroundColorAttributeName] CGColor];
    [self.scrollView.layer addSublayer:self.selectionIndicatorStripLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateSegmentsRects];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self updateSegmentsRects];
}

- (void)setSectionTitles:(NSArray<NSString *> *)sectionTitles {
    _sectionTitles = sectionTitles;
    _selectedSegmentIndex = (_selectedSegmentIndex < sectionTitles.count) ? _selectedSegmentIndex : 0;
    [self refreshCacheSegmentWidth];
    [self updateSegmentsRects];
    [self refreshSegmentButtons];
}

- (void)updateSegmentsRects {
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        return;
    }
    
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.scrollView.contentSize = CGSizeMake([self totalSegmentedControlWidth], CGRectGetHeight(self.frame));
}


// 刷新segment缓存高度
- (void)refreshCacheSegmentWidth {
    if (self.segmentWidthStyle == DYSegmentedControlSegmentWidthStyleDynamic) {
        NSMutableArray *mutableSegmentWidths = [NSMutableArray array];
        
        [self.sectionTitles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
            CGFloat stringWidth = [self measureTitleAtIndex:idx].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
            [mutableSegmentWidths addObject:[NSNumber numberWithFloat:stringWidth]];
        }];
        self.segmentWidthsArray = [mutableSegmentWidths copy];
    } else if (self.segmentWidthStyle == DYSegmentedControlSegmentWidthStyleFixed) {
        [self.sectionTitles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
            CGFloat stringWidth = [self measureTitleAtIndex:idx].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
            self.segmentWidth = MAX(stringWidth, self.segmentWidth);
        }];
    } else if (self.segmentWidthStyle == DYSegmentedControlSegmentWidthStyleContentFit) {
        self.segmentWidth = self.contentTotalWidth/self.sectionTitles.count;
    }
}

// 刷新segment按钮
- (void)refreshSegmentButtons {
    for (UIView *btn in _scrollView.subviews) {
        [btn removeFromSuperview];
    }
    
    CGFloat xOffset = 0;
    for (NSInteger i = 0; i < _sectionTitles.count; i++) {
        NSString *itemStr = _sectionTitles[i];
        CGFloat segmentWidth = [self segmentWidthAtIndex:i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(xOffset, 0, segmentWidth, _segmentedControlHeight)];
        btn.tag = kDYSegmentedControlBaseTag + i;
        [btn setTitle:itemStr forState:UIControlStateNormal];
        btn.titleLabel.font = self.titleTextAttributes[NSFontAttributeName];
        [btn setTitleColor:self.titleTextAttributes[NSForegroundColorAttributeName] forState:UIControlStateNormal];
        [self.scrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        xOffset = CGRectGetMaxX(btn.frame);
    }
    
    // 初始化选中按钮
    [self scrollToSelectedSegmentIndex:YES];
}

- (void)btnClicked:(UIButton *)btn {
    NSInteger index = btn.tag - kDYSegmentedControlBaseTag;
    _selectedSegmentIndex = index;
    [self scrollToSelectedSegmentIndex:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(segmentedControl:indexChanged:)]) {
        [_delegate segmentedControl:self indexChanged:index];
    }
}

#pragma mark - Drawing

- (CGSize)measureTitleAtIndex:(NSUInteger)index {
    if (index >= self.sectionTitles.count) {
        return CGSizeZero;
    }
    
    //    BOOL selected = (index == self.selectedSegmentIndex) ? YES : NO;
    //    NSDictionary *titleAttrs = selected ? [self resultingSelectedTitleTextAttributes] : [self resultingTitleTextAttributes];
    
    // 直接使用选中放大的size
    NSDictionary *titleAttrs = [self resultingSelectedTitleTextAttributes];
    CGSize size = [self.sectionTitles[index] sizeWithAttributes:titleAttrs];
    return CGRectIntegral((CGRect){CGPointZero, size}).size;
}

- (CGFloat)segmentWidthAtIndex:(NSInteger)index {
    return self.segmentWidthStyle == DYSegmentedControlSegmentWidthStyleDynamic ? self.segmentWidthsArray[index].floatValue : self.segmentWidth;
}

#pragma mark - Scrolling

- (CGFloat)totalSegmentedControlWidth {
    if (self.segmentWidthStyle == DYSegmentedControlSegmentWidthStyleFixed) {
        return self.sectionTitles.count * self.segmentWidth;
    } else {
        return [[self.segmentWidthsArray valueForKeyPath:@"@sum.self"] floatValue];
    }
}

- (void)scrollToSelectedSegmentIndex:(BOOL)animated {
    CGRect rectForSelectedIndex = CGRectZero;
    CGFloat selectedSegmentOffset = 0;
    
    if (self.segmentWidthStyle == DYSegmentedControlSegmentWidthStyleDynamic) {
        if (self.segmentWidthsArray.count == 0) { return; }
        
        NSInteger i = 0;
        CGFloat offsetter = 0;
        for (NSNumber *width in self.segmentWidthsArray) {
            if (self.selectedSegmentIndex == i)
                break;
            offsetter = offsetter + [width floatValue];
            i++;
        }

        CGFloat selectedSegmentWidth = [self.segmentWidthsArray[self.selectedSegmentIndex] floatValue];
        rectForSelectedIndex = CGRectMake(offsetter, 0, selectedSegmentWidth, self.frame.size.height);
        selectedSegmentOffset = (CGRectGetWidth(self.frame) / 2) - (selectedSegmentWidth / 2);
        
    } else {
        rectForSelectedIndex = CGRectMake(self.segmentWidth * self.selectedSegmentIndex, 0, self.segmentWidth, self.frame.size.height);
        selectedSegmentOffset = (CGRectGetWidth(self.frame) / 2) - (self.segmentWidth / 2);
    }
    
    
    CGRect rectToScrollTo = rectForSelectedIndex;
    rectToScrollTo.origin.x -= selectedSegmentOffset;
    rectToScrollTo.size.width += selectedSegmentOffset * 2;
    [self.scrollView scrollRectToVisible:rectToScrollTo animated:animated];

    // 切换按钮状态
    _lastSelectedButton.titleLabel.font = self.titleTextAttributes[NSFontAttributeName];
    [_lastSelectedButton setTitleColor:self.titleTextAttributes[NSForegroundColorAttributeName] forState:UIControlStateNormal];
    
    UIButton *btn = [self.scrollView viewWithTag:kDYSegmentedControlBaseTag + _selectedSegmentIndex];
    btn.titleLabel.font = self.selectedTitleTextAttributes[NSFontAttributeName];
    [btn setTitleColor:self.selectedTitleTextAttributes[NSForegroundColorAttributeName] forState:UIControlStateNormal];
    
    _lastSelectedButton = btn;
    
    // 底部指示器滚动
    CGFloat selectedSegmentOffsetCenterX = CGRectGetMidX(rectForSelectedIndex);
    self.selectionIndicatorStripLayer.frame = CGRectMake(selectedSegmentOffsetCenterX - self.selectionIndicatorSize.width/2, _segmentedControlHeight - self.selectionIndicatorSize.height, self.selectionIndicatorSize.width, self.selectionIndicatorSize.height);
}

#pragma mark - Index Change
- (void)setSelectedSegmentIndex:(NSInteger)index {
    [self setSelectedSegmentIndex:index animated:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated {
    if (index >= self.sectionTitles.count) {
        return;
    }
    _selectedSegmentIndex = index;
    [self scrollToSelectedSegmentIndex:animated];
}

#pragma mark - badge
//- (void)setRedDotForSegmentIndex:(NSUInteger)index {
//    CGFloat segmentWidth = [self measureTitleAtIndex:index].width/2;
//    UIButton *btn = [self.scrollView viewWithTag:kDYSegmentedControlBaseTag + index];
//    btn.badgeFrame = CGRectMake(CGRectGetMidX(btn.bounds) + segmentWidth - 5, 5, 10, 10);
//    btn.badge.layer.cornerRadius = 5.f;
//    [btn showBadge];
//}
//
//- (void)setBadgeForSegmentIndex:(NSUInteger)index badgeCount:(NSInteger)count {
//    if (count <= 0) {
//        [self clearBadgeForSegmentIndex:index];
//    } else {
//        CGFloat segmentWidth = [self measureTitleAtIndex:index].width/2;
//        UIButton *btn = [self.scrollView viewWithTag:kDYSegmentedControlBaseTag + index];
//        [btn showNumberBadgeWithValue:count];
//        btn.badge.frame = CGRectMake(CGRectGetMidX(btn.bounds) + segmentWidth - CGRectGetWidth(btn.badge.bounds)/2, 2, CGRectGetWidth(btn.badge.bounds), CGRectGetHeight(btn.badge.bounds));
//    }
//}
//
//- (void)clearBadgeForSegmentIndex:(NSUInteger)index {
//    UIButton *btn = [self.scrollView viewWithTag:kDYSegmentedControlBaseTag + index];
//    [btn clearBadge];
//}

#pragma mark - Styling Support
- (NSDictionary *)resultingTitleTextAttributes {
    NSDictionary *defaults = @{NSFontAttributeName : [UIFont systemFontOfSize:19.0f],
                               NSForegroundColorAttributeName : [UIColor blackColor]};
    
    NSMutableDictionary *resultingAttrs = [NSMutableDictionary dictionaryWithDictionary:defaults];
    if (self.titleTextAttributes) {
        [resultingAttrs addEntriesFromDictionary:self.titleTextAttributes];
    }
    return [resultingAttrs copy];
}

- (NSDictionary *)resultingSelectedTitleTextAttributes {
    NSMutableDictionary *resultingAttrs = [NSMutableDictionary dictionaryWithDictionary:[self resultingTitleTextAttributes]];
    if (self.selectedTitleTextAttributes) {
        [resultingAttrs addEntriesFromDictionary:self.selectedTitleTextAttributes];
    }
    return [resultingAttrs copy];
}

@end
