//
//  ZLNoteCell.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLNoteModel.h"

@interface ZLNoteCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *) tableView;

@property (nonatomic, strong) ZLNoteModel *noteModel;

@property (nonatomic,strong) UIColor *leftColor;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *noteBgView;
@property (weak, nonatomic) IBOutlet UILabel *leftBgLable;

@end
