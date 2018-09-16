//
//  FMDBManager.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLNoteModel.h"
#import "FMResultSet.h"

@interface FMDBManager : NSObject

+ (FMDBManager *)shareManager;

- (BOOL)insterDataWithModel:(ZLNoteModel *)model;

- (FMResultSet *)backResults:(NSString *)conditions;

- (FMResultSet *)selectFind:(NSString *)monthday;

- (FMResultSet *)selectGroup:(NSString *)category;

- (BOOL)deleteData;

- (BOOL)deleteFind:(int)unid;

- (BOOL)updateTag:(int)tag hour:(NSString *)hour;

- (BOOL)updateUid:(int)tag uid:(int)uid;

- (BOOL)updateStick:(int)stick uid:(int)uid;

- (BOOL)updateCategory:(NSString *)category hour:(NSString *)hour;

- (BOOL)updateHour:(int)tag hour:(NSString *) hour date:(NSString *)date uid:(int)uid;

- (BOOL)updateTime:(int)tag hour:(NSString *) hour date:(NSString *)date monthday:(NSString *)monthday uid:(int)uid;

- (BOOL)updateFind:(ZLNoteModel *) model;

- (BOOL)updateImg:(NSData *)imgData unid:(int)unid;

@end
