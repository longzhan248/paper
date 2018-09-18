//
//  NSString+ZLSizeLab.h
//  paper
//
//  Created by 詹龙 on 2018/9/18.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZLSizeLab)

/**
 *  计算一个字符串在限定的宽度和字体下的长度
 *
 *  @param font  限定的字体
 *  @param width 限定的宽度
 *
 *  @return 字符串的长度
 */
- (CGSize)heightWithFont:(UIFont* )font width:(CGFloat)width;

- (NSAttributedString *)LabelContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
