//
//  BaseViewController.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController <UIGestureRecognizerDelegate> {
    UIButton *rightBarButton;
    UIWindow *windows;
}

@property(nonatomic, assign) BOOL isRight;

- (UIImage *)screenShot;

@property(nonatomic, assign) BOOL isRightButton;
@property(nonatomic, assign) BOOL isBackButton;

- (void)setNavigationTitle:(NSString *)title;
- (void)setNavigationWTitle:(NSString *)title;
- (void)setNavigationImg:(UIImage *)image;
- (void)backAction;

@end
