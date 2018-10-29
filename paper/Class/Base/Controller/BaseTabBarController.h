//
//  BaseTabBarController.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTabBar.h"
#import "HyPopMenuView.h"

@interface BaseTabBarController : UITabBarController<buttonViewDelegate, HyPopMenuViewDelegate>
{
    PopMenuModel *model;
    PopMenuModel *model2;
    PopMenuModel *model3;
    
    UIButton *titleButton;
    UIButton *lastButton;
}

@property (nonatomic,strong) ZLTabBar       *zlTabBar;
@property (nonatomic, strong) HyPopMenuView *menu;

- (void)showTabbar:(BOOL)show;

@end
