//
//  CommonUtil.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "ZLNotificationManager.h"

typedef void (^buttonBlock)(UIButton *button);

@interface CommonUtil : NSObject
{
    
    NSMutableAttributedString    *attributeString;
    NSAttributedString           *attributedString;
}

+ (id)shareInstance;

+ (void)registerNotice:(NSString *)keyString object:(NSObject*)object;

#pragma mark
+ (NSString*)turnToEmojiTextWithString:(NSString *)string;
#pragma mark - 时间戳转换时间
+ (NSString *)timeIntervalTurnDate:(NSString *)string;
+ (NSString *)YearMonthIntervalTurnDate:(NSString *)string;
+ (NSString *)YearIntervalTurnDate:(NSString *)string;
+ (NSString *)MonthIntervalTurnDate:(NSString *)string;
#pragma mark - 获取时间
+ (NSString *)getLocalTime;

+ (NSString*)TimeformatFromSeconds:(int)seconds;

+ (NSString*)TotalTimeformatFromSeconds:(int)seconds;

+ (NSString*)changeTime:(NSDate*)onedate toDateString:(NSString*)str;
+ (void)date;
+ (NSString*)dateChangeFormatAt:(NSString *)createdAt;

- (NSAttributedString *)labelContent:(NSString *)content;

- (NSAttributedString *)labelInteractContent:(NSString *)content;

+ (NSString *)generateUuidString;

- (NSMutableAttributedString *)attributeString:(NSString *)content;
- (NSMutableAttributedString *)attributeString2:(NSString *)agree;

// 判断是否有网络
+ (BOOL)connectedToNetwork;

- (BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore:(NSString *)string;

+ (id)StringTurnJSON:(NSString *)jsonStr;

- (AppDelegate *)myDelegate;


+ (void)userDefaultModel:(id)model modelKey:(NSString *)key;

+ (void)NotiTip:(NSString *)tip color:(UIColor *)color;

+ (void)NavigationLoading:(UIView *)view;

@end
