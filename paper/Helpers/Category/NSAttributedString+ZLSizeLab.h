//
//  NSAttributedString+ZLSizeLab.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (ZLSizeLab)

/**
 *  计算一个字符串在限定的宽度和字体下的长度
 *
 *  @param font  限定的字体
 *  @param width 限定的宽度
 *
 *  @return 字符串的长度
 */

- (CGSize)zl_heightWithLabelWidth:(CGFloat)width;
- (NSString *)zl_setCreatedDateFormatAt:(NSString *)createdAt;

@end
