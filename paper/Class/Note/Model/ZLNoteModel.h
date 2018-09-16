//
//  ZLNoteModel.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "Jastor.h"

@interface ZLNoteModel : Jastor

@property (nonatomic,assign) int uid;

@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *note;

@property (nonatomic,assign) int starTag;
@property (nonatomic,assign) int colorTag;

@property (nonatomic,copy) NSData *imgData;
@property (nonatomic,copy) NSString *ctime;

// 预留字段
@property (nonatomic,copy) NSString *title;

@end
