//
//  VendorMacro.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#ifndef VendorMacro_h
#define VendorMacro_h

#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define IOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

#define IS_IPAD     [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

//iPhone4
#define iPhone4 [UIScreen mainScreen].bounds.size.height<=480.0f
//iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhone5s
#define IPhone5S [UIScreen mainScreen].bounds.size.height<=568.0f
//iphone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

//iphone6plus
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)


//字体相关
#define FONT_PING_BOLD(FONTSIZE) [UIFont fontWithName:@"PingFang-SC-Bold" size:(FONTSIZE)]
#define FONT_PING_REGULAR(FONTSIZE) [UIFont fontWithName:@"PingFang-SC-Regular" size:(FONTSIZE)]

//屏幕尺寸相关
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define iOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)

#define REFRESH_HEIGHT              41  //自定义UITabBar的高度
#define STATEBAR_HEIGHT             20  //状态栏的高度
#define TABBAR_HEIGHT               49  //自定义UITabBar的高度

#define BOTTOM_HEIGHT               80  //botoom高度

#define NAVIGATIONHEIGHT            64

#define TABBAR_BUTTON_WIDTH         ScreenWidth/5

#define NOTEHEADER_HEIGHT           200

#define NOTEBGCELL_HEIGHT           75

#define NOTEBGCELL_PADDING_HEIGHT   8

#define LEFT_PADDING_HEIGHT         15

//图片资源
#define TB_NOTE                          @"tabbar_icon_memo_unselect"
#define TB_CAPSULE                       @"tabbar_icon_capsule_unselect"
#define TB_PUBLISH                       @"tabbar_icon_add"
#define TB_TARGET                        @"tabbar_icon_target_unselect"
#define TB_SETTING                       @"tabbar_icon_set_unselect"

#define TB_NOTE_SELECT                   @"tabbar_icon_memo_select"
#define TB_CAPSULE_SELECT                @"tabbar_icon_capsule_select"
#define TB_TARGET_SELECT                 @"tabbar_icon_target_select"
#define TB_SETTING_SELECT                @"tabbar_icon_set_select"

#define PUBLISH_NOTE_IMG                 @"publish_icon_memo"
#define PUBLISH_CAPSULE_IMG              @"publish_icon_capsule"
#define PUBLISH_TARGET_IMG               @"publish_icon_target"
#define PUBLISH_CLOSE_IMG                @"publish_icon_close"

#define SL_NAVIGATION_IMG                @"navgation_bg.png"

#define NAVIGATIONBAR_BACK_IMG           @"back"

#define NAVIGATIONBAR_BACK_WIMG          @"back_white"

#define NOTE_TOP_BG_IMG                  @"home_bg"

#define TABBAR_IMG   @[TB_NOTE,TB_CAPSULE,TB_PUBLISH,TB_TARGET,TB_SETTING];

#define TABBAR_SELECT_IMG   @[TB_NOTE_SELECT,TB_CAPSULE_SELECT,TB_PUBLISH,TB_TARGET_SELECT,TB_SETTING_SELECT];


#endif /* VendorMacro_h */
