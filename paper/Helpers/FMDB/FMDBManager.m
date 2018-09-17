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
            [self creatList];
        }else{
            NSLog(@"------------失败");
        }
        
    }
    return self;
}

- (void)creatList {
    BOOL result = [fmdb executeUpdate:@"create table if not exists note(uid varchar ,title varchar,content varchar ,starTag varchar , colorTag varchar , width varchar ,height varchar , imgData blob ,ctime varchar)"];
    if (result) {
        NSLog(@"==========创建表成功");
    }else{
        NSLog(@"----------失败");
    }
}

- (BOOL)insterDataWithModel:(ZLNoteModel *)model
{
    BOOL isSucess = [fmdb executeUpdate:@"insert into note(uid , title , content , starTag , colorTag , width, height, imgData ,ctime) values(?,?,?,?,?,?,?,?,?)",@(model.uid),model.title,model.content,@(model.starTag),@(model.colorTag),@(model.width),@(model.height),model.imgData,model.ctime];
    if (isSucess) {
        NSLog(@"===========插入数据成功");
    }else{
        NSLog(@"-----------失败");
    }
    return isSucess;
}

- (FMResultSet *)backResults:(NSString *)conditions {
    NSString *querySql = [NSString stringWithFormat:@"select * from %@ ORDER BY ctime desc",conditions];
    return  [fmdb executeQuery:querySql];
}

- (FMResultSet *)searchResults:(NSString *)conditions
{
    NSString *querySql = [NSString stringWithFormat:@"select * from app where title like '%%%@%%' ",conditions];
    return  [fmdb executeQuery:querySql];
}

- (FMResultSet *)surveyResults:(NSString *)conditions
{
    
    NSString *querySql = [NSString stringWithFormat:@"select * from %@ ORDER BY tag desc , hour asc",conditions];
    return  [fmdb executeQuery:querySql];
}

- (FMResultSet *)lineResults:(NSString *)conditions
{
    NSString *querySql = [NSString stringWithFormat:@"select * from %@ ORDER BY monthday desc",conditions];
    return  [fmdb executeQuery:querySql];
}

- (FMResultSet *)selectFind:(NSString *)monthday
{
    NSString *querySql = [NSString stringWithFormat:@"select * from app where monthday = '%@' ORDER BY tag desc , hour asc",monthday];
    
    return  [fmdb executeQuery:querySql];
}

- (FMResultSet *)selectGroup:(NSString *)category
{
    NSString *querySql = [NSString stringWithFormat:@"select * from app where category = '%@' ORDER BY ctime desc",category];
    
    return  [fmdb executeQuery:querySql];
}

- (BOOL)deleteFind:(int)unid {
    NSString *deleteSql = [NSString stringWithFormat:@"delete from app where uid = %d",unid];
    BOOL result = [fmdb executeUpdate:deleteSql];
    return result;
}

- (BOOL)updateFind:(ZLNoteModel *)model
{
    NSString *updateSql = [NSString stringWithFormat:@"update note set content = '%@', colorTag = %d,width = %f,height = %f,imgData= '%@',ctime = '%@' where uid =%d",model.content,model.colorTag,model.width,model.height,model.imgData,model.ctime,model.uid];
    
    BOOL result = [fmdb executeUpdate:updateSql];
    
    return result;
}

- (BOOL)updateImg:(NSData *)imgData unid:(int)unid {
    NSString *updateSql = @"update app set img = ? where uid = ?";
    BOOL result = [fmdb executeUpdate:updateSql,imgData,unid];
    
    return result;
}

- (BOOL)updateTag:(int)tag hour:(NSString *)hour {
    NSString *updateSql = [NSString stringWithFormat:@"update app set tag= %d where hour = '%@'",tag,hour];
    
    BOOL result = [fmdb executeUpdate:updateSql];
    
    return result;
}

- (BOOL)updateUid:(int)tag uid:(int)uid {
    NSString *updateSql = [NSString stringWithFormat:@"update app set tag= %d where uid = '%d'",tag,uid];
    
    BOOL result = [fmdb executeUpdate:updateSql];
    
    return result;
}

- (BOOL)updateStick:(int)stick uid:(int)uid {
    NSString *updateSql = [NSString stringWithFormat:@"update app set stick= %d where uid = '%d'",stick,uid];
    
    BOOL result = [fmdb executeUpdate:updateSql];
    
    return result;
}

- (BOOL)updateCategory:(NSString *)category hour:(NSString *)hour {
    NSString *updateSql = [NSString stringWithFormat:@"update app set category= '%@' where hour = '%@'",category,hour];
    
    BOOL result = [fmdb executeUpdate:updateSql];
    
    return result;
}

- (BOOL)updateHour:(int)tag hour:(NSString *)hour date:(NSString *)date uid:(int)uid {
    NSString *updateSql = [NSString stringWithFormat:@"update app set tag= %d , date='%@' , hour = '%@' where uid = '%d'",tag,date,hour,uid];
    
    BOOL result = [fmdb executeUpdate:updateSql];
    
    return result;
}

- (BOOL)updateTime:(int)tag hour:(NSString *)hour date:(NSString *)date monthday:(NSString *)monthday uid:(int)uid {
    NSString *updateSql = [NSString stringWithFormat:@"update app set tag= %d , date='%@' , hour = '%@' , monthday = '%@' where uid = '%d'",tag,date,hour,monthday,uid];
    
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
