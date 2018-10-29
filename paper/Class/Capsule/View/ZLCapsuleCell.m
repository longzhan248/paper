//
//  ZLCapsuleCell.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLCapsuleCell.h"
#import "ZLCapsuleModel.h"

@interface ZLCapsuleCell ()

@property (weak, nonatomic) IBOutlet UIImageView *statusImg;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

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

- (void)setCapsuleModel:(ZLCapsuleModel *)capsuleModel {
    if (capsuleModel.statusTag == 0) {
        _statusImg.image = [UIImage imageNamed:@"publish_capsule_calm"];
    } else if (capsuleModel.statusTag==1){
        _statusImg.image = [UIImage imageNamed:@"publish_capsule_pretty"];
    } else if (capsuleModel.statusTag==2){
        _statusImg.image = [UIImage imageNamed:@"publish_capsule_bad"];
    }
    
    _dateLabel.text = capsuleModel.cdate;
    _contentLabel.text = capsuleModel.content;
}


@end
