//
//  PopMenuButton.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "HyPopMenuView.h"
#import <UIKit/UIKit.h>

typedef void (^completionAnimation)();

@interface PopMenuButton : UIButton

@property (nonatomic, nonnull, strong) PopMenuModel* model;

@property (nonatomic, nonnull, strong) completionAnimation block;

- (instancetype __nonnull)init;
- (void)selectdAnimation;
- (void)cancelAnimation;

@end
