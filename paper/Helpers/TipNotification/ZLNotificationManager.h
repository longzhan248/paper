//
//  ZLNotificationManager.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZL_TEXT_FONT_KEY @"ZL_TEXT_FONT_KEY"
#define ZL_TEXT_COLOR_KEY @"ZL_TEXT_COLOR_KEY"
#define ZL_DELAY_SECOND_KEY @"ZL_DELAY_SECOND_KEY"
#define ZL_BACKGROUND_COLOR_KEY @"ZL_BACKGROUND_COLOR_KEY"

typedef void(^ZLCompleteBlock)(void);

@interface ZLNotificationManager : NSObject 

@property (nonatomic) CGFloat delaySeconds; //延迟几秒消失
@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic,copy) ZLCompleteBlock completeBlock;

+ (instancetype)shareManager;
+ (void)setOptions:(NSDictionary *)options;

+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message withOptions:(NSDictionary *)options;
+ (void)showMessage:(NSString *)message withOptions:(NSDictionary *)options completeBlock:(void(^)(void))completeBlock;

@end
