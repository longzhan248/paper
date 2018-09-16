//
//  UtilsMacro.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//  

#ifndef UtilsMacro_h
#define UtilsMacro_h

//文本设置
#define ZLLangaueStr(key) [[NSBundle mainBundle] localizedStringForKey:key value:nil table:@"zh-Hans"]

//强弱引用
#define DTStrongObj(o) autoreleasepool{} __strong typeof(o) o = weak##o;
#define DTWeakObj(o) autoreleasepool{} __weak typeof(o) weak##o = o;

//rgb
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//ox....
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define WHITE           0xFFFFFF

#define LINE_COLOR      0xF5F5F5

#define BG_COLOR        0xF8F8F8

#define BLACK           0x231815

#define SMALLGRAY       0x999999

#define MAIN_COLOR      0X118DFD

#define CAPSULE_BLUE_CLOR 0X409BF9

#define CAPSULE_TOP     0XBBBBBB

#define SECOND_COLOR    0X8CB6D0

#define GRAY            0x666666

#define LINE_GRAY       0xdfdfdf

#define NOTE_PURPLE     kUIColorFromRGB(0x845EF0)
#define NOTE_RED        kUIColorFromRGB(0xFD8980)
#define NOTE_GREEN      kUIColorFromRGB(0x32D2B8)
#define NOTE_YELLOW     kUIColorFromRGB(0xFACC4F)

#define TIP_COLOR        kUIColorFromRGB(0x7F7978)
#define SUCCESS_COLOR    kUIColorFromRGB(0x2FCBF9)
#define WARNNING_COLOR   kUIColorFromRGB(0xfa5459)

//全局变量属性
#define app         [[CommonUtil shareInstance] myDelegate]

#define AF_CODE     [app.resObject objectForKey:@"code"]
#define AF_MSG      [app.resObject objectForKey:@"msg"]
#define AF_CONTENT  [app.resObject objectForKey:@"content"]

#define USERDEFAULT [NSUserDefaults standardUserDefaults]

#define NSNOTIFICATION [NSNotificationCenter defaultCenter]

#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


#endif /* UtilsMacro_h */
