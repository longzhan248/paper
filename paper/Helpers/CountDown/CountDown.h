//
//  CountDown.h
//  paper
//
//  Created by apple on 2018/10/26.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountDown : NSObject

///用NSDate日期倒计时
- (void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;
///用时间戳倒计时
- (void)countDownWithStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;
///每秒走一次，回调block
- (void)countDownWithPER_SECBlock:(void (^)(void))PER_SECBlock;
- (void)destoryTimer;
- (NSDate *)dateWithLongLong:(long long)longlongValue;

@end

