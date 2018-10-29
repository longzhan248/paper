//
//  BaseNavigationController.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define kkBackViewHeight [UIScreen mainScreen].bounds.size.height
#define kkBackViewWidth [UIScreen mainScreen].bounds.size.width

#define iOS7  ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

#define startX -200;

@interface BaseNavigationController : UINavigationController <UIGestureRecognizerDelegate>
{
    BOOL animating;
    
    CGFloat startBackViewX;
    BOOL firstTouch;
}

@property (nonatomic,assign) BOOL canDragBack;

@end
