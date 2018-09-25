//
//  ZLCapsuleModel.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "Jastor.h"

@interface ZLCapsuleModel : Jastor

@property (nonatomic,assign) int uid;
//预留字段
@property (nonatomic,copy) NSString *title;
//状态标识  平静的一天0、不错的一天1、难过的一天2
@property (nonatomic,assign) int statusTag;
@property (nonatomic,copy) NSString *content;
//标识今天还是未来 0今天 1未来
@property (nonatomic,assign) int today;

//图片的宽高度
@property (nonatomic,assign) float width;
@property (nonatomic,assign) float height;
@property (nonatomic,copy) NSData *imgData;

//今天时间
@property (nonatomic,copy) NSString *cdate;
//更详细的时间
@property (nonatomic,copy) NSString *ctime;

@end
