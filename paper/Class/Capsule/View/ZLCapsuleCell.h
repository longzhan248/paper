//
//  ZLCapsuleCell.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLCapsuleModel;

@interface ZLCapsuleCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) ZLCapsuleModel *capsuleModel;

@end
