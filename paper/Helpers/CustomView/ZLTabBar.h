//
//  ZLTabBar.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 协议
@protocol buttonViewDelegate <NSObject>
@optional
- (void)clickButtonWithIndex:(NSInteger)index;

@end

@interface ZLTabBar : UIView

@property (nonatomic,weak) id<buttonViewDelegate> delegate;

+ (instancetype)buttonView;

@end
