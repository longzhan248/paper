//
//  ZLTargetCell.m
//  paper
//
//  Created by 詹龙 on 2018/9/29.
//  Copyright © 2018 longzhan. All rights reserved.
//

#import "ZLTargetCell.h"
#import "ZLTargetModel.h"

@interface ZLTargetCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *remindImg;

@end

@implementation ZLTargetCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"targetCell";
    ZLTargetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZLTargetCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setTargetModel:(ZLTargetModel *)targetModel {
    if (targetModel.statusTag == 0) {
        _bgImgView.image = [UIImage imageNamed:@"bg_blue"];
        _remindImg.image = [UIImage imageNamed:@"icon_unremind"];
    } else {
        _bgImgView.image = [UIImage imageNamed:@"bg_yellow"];
        _remindImg.image = [UIImage imageNamed:@"icon_remind"];
    }
    
    _titleLabel.text = targetModel.title;
    _contentLabel.text = targetModel.content;
    _timeLabel.text = [CommonUtil dateChangeFormatAt:[CommonUtil timeIntervalTurnDate:targetModel.ctime]];
}

@end
