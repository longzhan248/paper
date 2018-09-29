//
//  ZLTargetCell.h
//  paper
//
//  Created by 詹龙 on 2018/9/29.
//  Copyright © 2018 longzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLTargetModel;

@interface ZLTargetCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)  ZLTargetModel *targetModel;

@end

