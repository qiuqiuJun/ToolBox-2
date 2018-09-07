//
//  IZCBaseTableViewCell.m
//  iZichanSalary
//
//  Created by PeterZhang on 16/4/27.
//  Copyright © 2016年 YiZhan. All rights reserved.
//

#import "TLBaseTableViewCell.h"

@implementation TLBaseTableViewCell

+ (NSString *)reuseId {
    return NSStringFromClass(self.class);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.exclusiveTouch = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

// 填充单元格内容
- (void)setCellContentWithObject:(id)item
{
    self.item = item;
}

// 计算单元格高度
+ (float)getCellHeightWithObject:(id)item
{
    return 0;
}

- (void)setObject:(id)item
{
    self.item = item;
}
- (void)setObject:(id)item withWidth:(CGFloat)width
{
    self.item = item;
}
//-(void)setObject:(id)item atIndex:(NSIndexPath *)idx{
//    self.item = item;
//    self.idx = idx;
//}

+ (float)GetHeightForCell{
    return 60;
}

+ (float)GetHeightForCell:(id)item{
    return 60;
}


- (float)getCellHeight{
    return 0;
}

+ (CGFloat)getHeightForCell:(id)object withWidth:(CGFloat)width
{
    return 0;
}

@end
