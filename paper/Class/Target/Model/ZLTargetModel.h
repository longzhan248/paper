//
//  ZLTargetModel.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "Jastor.h"

@interface ZLTargetModel : Jastor

@property (nonatomic, assign) int uid;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
//截止时间
@property (nonatomic, copy) NSString *endDate;
//状态标识 0 不提醒 1提醒
@property (nonatomic, assign) int statusTag;
//创建时间
@property (nonatomic, copy) NSString *ctime;

@end
