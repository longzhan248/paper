//
//  FMDBManager.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDatabase.h"

@implementation FMDBManager
{
    FMDatabase *fmdb;
}

+ (FMDBManager *)shareManager {
    static FMDBManager *db = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (db == nil) {
            db = [[FMDBManager alloc] init];
        }
    });
    return db;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //获取数据库文件路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [doc stringByAppendingPathComponent:@"app.sqlite"];
        fmdb = [[FMDatabase alloc] initWithPath:fileName];
        if ([fmdb open]) {
            NSLog(@"============成功");
            [self createNote];
        }else{
            NSLog(@"------------失败");
        }
        
    }
    return self;
}

#pragma mark - 创建便签表
- (void)createNote {
    BOOL result = [fmdb executeUpdate:@"create table if not exists note(uid varchar ,title varchar ,content varchar ,starTag varchar ,colorTag varchar ,width varchar ,height varchar ,imgData blob ,ctime varchar)"];
    if (result) {
        NSLog(@"==========创建表成功");
    }else{
        NSLog(@"----------失败");
    }
}

#pragma mark - 创建胶囊表
- (void)createCapsule {
    BOOL result = [fmdb executeUpdate:@"create table if not exists capsule(uid varchar ,title varchar ,content varchar ,statusTag varchar ,today varchar ,width varchar ,height varchar ,imgData blob ,cdate varchar ,ctime varchar)"];
    if (result) {
        NSLog(@"==========创建表成功");
    }else{
        NSLog(@"----------失败");
    }
}

#pragma mark - 创建目标表
- (void)createTarget {
    BOOL result = [fmdb executeUpdate:@"create table if not exists target(uid varchar ,title varchar ,content varchar ,endDate varchar ,statusTag varchar ,ctime varchar)"];
    if (result) {
        NSLog(@"==========创建表成功");
    }else{
        NSLog(@"----------失败");
    }
}

#pragma mark - 表插入数据
/// 便签model插入数据
- (BOOL)insertDataWithModel:(ZLNoteModel *)model
{
    BOOL isSucess = [fmdb executeUpdate:@"insert into note(uid , title , content , starTag , colorTag , width, height, imgData ,ctime) values(?,?,?,?,?,?,?,?,?)",@(model.uid),model.title,model.content,@(model.starTag),@(model.colorTag),@(model.width),@(model.height),model.imgData,model.ctime];
    if (isSucess) {
        NSLog(@"===========插入数据成功");
    }else{
        NSLog(@"-----------失败");
    }
    return isSucess;
}

/// 胶囊model插入数据
- (BOOL)insertCapsuleDataWithModel:(ZLCapsuleModel *)model {
    BOOL isSucess = [fmdb executeUpdate:@"insert into capsule(uid , title , content ,statusTag, today , width, height , imgData ,cdate,ctime) values(?,?,?,?,?,?,?,?,?,?)",@(model.uid),model.title,model.content,@(model.statusTag),@(model.today),@(model.width),@(model.height),model.imgData,model.cdate,model.ctime];
    if (isSucess) {
        NSLog(@"===========插入数据成功");
    }else{
        NSLog(@"-----------失败");
    }
    return isSucess;
}

/// 目标model插入数据
- (BOOL)insertTargetDataWithModel:(ZLTargetModel *)model {
    BOOL isSuccess = [fmdb executeUpdate:@"insert into target(uid ,title ,content ,endDate ,statusTag ,ctime) values(?,?,?,?,?,?)", @(model.uid), model.title, model.content, model.endDate, @(model.statusTag), model.ctime];
    if (isSuccess) {
        NSLog(@"===========插入数据成功");
    }else{
        NSLog(@"-----------失败");
    }
    return isSuccess;
}

#pragma mark - 表查询数据
/// 返回便签查询结果
- (FMResultSet *)backResults:(NSString *)conditions {
    NSString *querySql = [NSString stringWithFormat:@"select * from %@ ORDER BY ctime desc",conditions];
    return  [fmdb executeQuery:querySql];
}

/// 返回胶囊查询结果
- (FMResultSet *)backCapsuleResult:(NSString *)conditions today:(int)today {
    NSString *querySql = [NSString stringWithFormat:@"select * from %@ where today=%d ORDER BY ctime desc", conditions, today];
    return [fmdb executeQuery:querySql];
}

/// 返回目标查询结果
- (FMResultSet *)backTargetDataWithModel:(NSString *)conditions {
    NSString *querySql = [NSString stringWithFormat:@"select * from %@ ORDER BY ctime desc", conditions];
    return [fmdb executeQuery:querySql];
}

#pragma mark - 其他
/// 返回查询结果
- (FMResultSet *)selectFind:(NSString *)conditions
{
    NSString *querySql = [NSString stringWithFormat:@"select * from %@ where today=0 ORDER BY ctime desc limit 1",conditions];
    return  [fmdb executeQuery:querySql];
}

- (BOOL)deleteFind:(NSString *)conditions uid:(int)uid {
    NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where uid = %d",conditions,uid];
    BOOL result = [fmdb executeUpdate:deleteSql];
    return result;
}

/// 图片格式无法通过此种方式修改，待探究
- (BOOL)updateFind:(ZLNoteModel *)model
{
    NSString *updateSql = [NSString stringWithFormat:@"update note set content = '%@', colorTag = %d,width = %f,height = %f,imgData= '%@',ctime = '%@' where uid =%d",model.content,model.colorTag,model.width,model.height,model.imgData,model.ctime,model.uid];
    
    BOOL result = [fmdb executeUpdate:updateSql];
    
    return result;
}

- (BOOL)deleteData {
    NSString *deleteSql = [NSString stringWithFormat:@"delete from %@",@"app"];
    BOOL result = [fmdb executeUpdate:deleteSql];
    if (result) {
        NSLog(@"--------删除表");
    }else{
        NSLog(@"========失败");
    }
    return result;
}

@end
