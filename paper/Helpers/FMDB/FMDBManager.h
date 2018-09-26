//
//  FMDBManager.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLNoteModel.h"
#import "ZLCapsuleModel.h"
#import "FMResultSet.h"

@interface FMDBManager : NSObject

+ (FMDBManager *)shareManager;

- (void)createNote;

- (void)createCapsule;

- (BOOL)insertDataWithModel:(ZLNoteModel *)model;

- (BOOL)insertCapsuleDataWithModel:(ZLCapsuleModel *)model;

/// 返回便签查询结果
- (FMResultSet *)backResults:(NSString *)conditions;

/// 返回胶囊查询结果
- (FMResultSet *)backCapsuleResult:(NSString *)conditions today:(int)today;

/// 查询某一个胶囊
- (FMResultSet *)selectFind:(NSString *)conditions;

- (BOOL)deleteData;

/// 删除某一条数据
- (BOOL)deleteFind:(NSString *)conditions uid:(int)uid;

- (BOOL)updateFind:(ZLNoteModel *)model;


@end
