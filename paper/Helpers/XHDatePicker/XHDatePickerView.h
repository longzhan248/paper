//
//  XHDatePickerView.h
//  paper
//
//  Created by 詹龙 on 2018/9/21.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    DateStyleShowYearMonthDayHourMinute  = 0,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowYearMonthDay,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute
} XHDateStyle;

typedef enum{
    DateTypeStartDate,
    DateTypeEndDate
} XHDateType;

@interface XHDatePickerView : UIView

@property (nonatomic, assign) XHDateStyle datePickerStyle;
@property (nonatomic, assign) XHDateType dateType;
@property (nonatomic, strong) UIColor *themeColor;

//限制最大时间（没有设置默认2049）
@property (nonatomic, strong) NSDate *maxLimitDate;
//限制最小时间（没有设置默认1970）
@property (nonatomic, strong) NSDate *minLimitDate;

- (instancetype)initWithCompleteBlock:(void(^)(NSDate *,NSDate *))completeBlock;

/**
 *   设置打开选择器时的默认时间，
 *   minLimitDate < currentDate < maxLimitDate  显示 currentDate;
 *   currentDate < minLimitDate ||  currentDate > maxLimitDate   显示minLimitDate;
 */
- (instancetype)initWithCurrentDate:(NSDate *)currentDate CompleteBlock:(void(^)(NSDate *,NSDate *))completeBlock;

- (void)show;

@end
