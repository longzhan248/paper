//
//  ZLCapsuleCell.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLCapsuleCell.h"

@implementation ZLCapsuleCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"capsuleCell";
    ZLCapsuleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZLCapsuleCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height = NOTEBGCELL_HEIGHT;
    frame.size.height -= NOTEBGCELL_PADDING_HEIGHT;
    [super setFrame:frame];
}


@end
