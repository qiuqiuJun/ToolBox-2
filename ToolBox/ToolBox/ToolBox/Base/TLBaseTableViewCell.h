//
//  IZCBaseTableViewCell.h
//  iZichanSalary
//
//  Created by PeterZhang on 16/4/27.
//  Copyright © 2016年 YiZhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMacroUtility.h"
#import "Masonry.h"
#define kBackgroundColor DevGetColorFromRGB(238, 238, 238)

@interface TLBaseTableViewCell : UITableViewCell
@property (class, nonatomic, readonly) NSString *reuseId; /**<复用id*/
@property (nonatomic, strong) id item;/**< 单元格内容*/

/**
 *  填充单元格内容
 *
 *  @param item 单元格内容
 */
- (void)setCellContentWithObject:(id)item;

/**
 *  计算单元格高度
 *
 *  @param item 单元格内容
 *
 *  @return 单元格高度
 */
+ (float)getCellHeightWithObject:(id)item;

/**
 *  更新单元格内容
 *
 *  @param item 数据
 */
- (void)setObject:(id)item;
- (void)setObject:(id)item withWidth:(CGFloat)width;

///**
// *  更新单元格内容
// *
// *  @param item 数据
// *  @param idx  索引
// */
//-(void)setObject:(id)item atIndex:(NSIndexPath *)idx;

/**
 *  计算单元格高度
 *
 *  @return 单元格高度
 */
+ (float)GetHeightForCell;
+ (float)GetHeightForCell:(id)item;
+ (CGFloat)getHeightForCell:(id)object withWidth:(CGFloat)width;

- (float)getCellHeight;

@end
