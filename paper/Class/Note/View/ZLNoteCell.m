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

- (void)setNoteModel:(ZLNoteModel *)noteModel {
    _dateLabel.text = [CommonUtil dateChangeFormatAt:[CommonUtil timeIntervalTurnDate:noteModel.ctime]];
    _contentLabel.text = noteModel.content;

    if (noteModel.colorTag==0) {
        _leftBgLable.backgroundColor = NOTE_GREEN;
    }else if (noteModel.colorTag==1){
        _leftBgLable.backgroundColor = NOTE_RED;
    }else if (noteModel.colorTag==2){
        _leftBgLable.backgroundColor = NOTE_YELLOW;
    }else if (noteModel.colorTag==3){
        _leftBgLable.backgroundColor = NOTE_PURPLE;
    }
}

@end
