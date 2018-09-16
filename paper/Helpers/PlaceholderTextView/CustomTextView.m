//
//  CustomTextView.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView

//光标高度
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect originalRect = [super caretRectForPosition:position];
    originalRect.size.height = 18.;
    return originalRect;
}

@end
