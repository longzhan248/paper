//
//  UIView+ZLAdditions.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "UIView+ZLAdditions.h"

@implementation UIView (ZLAdditions)

- (BaseViewController *)viewController
{
    //事件响应链 下一个响应者
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[BaseViewController class]]) {
            return (BaseViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}

@end
