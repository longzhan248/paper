//
//  HyPopMenuViewDelegate.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HyPopMenuView, PopMenuModel, PopMenuButton;

@protocol HyPopMenuViewDelegate <NSObject>

- (void)popMenuView:(HyPopMenuView*)popMenuView didSelectItemAtIndex:(NSUInteger)index;

//....
@end
