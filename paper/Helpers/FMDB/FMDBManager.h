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
#import "ZLTargetModel.h"
#import "FMResultSet.h"

@interface FMDBManager : NSObject

+ (FMDBManager *)shareManager;

/// 创建便签数据库
- (void)createNote;

/// 创建胶囊数据库
- (void)createCapsule;

/// 创建目标数据库
- (void)createTarget;

/// 插入便签数据
- (BOOL)insertDataWithModel:(ZLNoteModel *)model;

/// 插入胶囊数据
- (BOOL)insertCapsuleDataWithModel:(ZLCapsuleModel *)model;

/// 插入u目标数据
- (BOOL)insertTargetDataWithModel:(ZLTargetModel *)model;

/// 返回便签查询结果
- (FMResultSet *)backResults:(NSString *)conditions;

/// 返回胶囊查询结果
- (FMResultSet *)backCapsuleResult:(NSString *)conditions today:(int)today;

/// 返回目标查询结果
- (FMResultSet *)backTargetDataWithModel:(NSString *)conditions;

/// 查询某一个胶囊
- (FMResultSet *)selectFind:(NSString *)conditions;

/// 删除数据库
- (BOOL)deleteData;

/// 删除某一条数据
- (BOOL)deleteFind:(NSString *)conditions uid:(int)uid;


- (BOOL)updateFind:(ZLNoteModel *)model;


@end
