//
//  ZLNoteCell.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLNoteCell.h"

@implementation ZLNoteCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"noteCell";
    ZLNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZLNoteCell" owner:self options:nil] lastObject];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = kUIColorFromRGB(LINE_COLOR);
        cell.highlighted = NO;
    }
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height = NOTEBGCELL_HEIGHT;
    frame.size.height -= NOTEBGCELL_PADDING_HEIGHT;
    [super setFrame:frame];
}

- (void)setLeftColor:(UIColor *)leftColor
{
    _leftBgLable.backgroundColor = leftColor;
}



@end
