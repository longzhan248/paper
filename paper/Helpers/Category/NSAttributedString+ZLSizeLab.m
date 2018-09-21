//
//  NSAttributedString+ZLSizeLab.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "NSAttributedString+ZLSizeLab.h"
#import "UIDevice+ZLLigs.h"

@implementation NSAttributedString (ZLSizeLab)

- (CGSize)zl_heightWithLabelWidth:(CGFloat)width {
    CGRect bounds = CGRectZero;
    
    //UIDevic的类别，用来判断是否是iOS7
    if ([UIDevice zl_isIOS7]) {
        //iOS7计算文字高度的方法。
        //        bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
        
    }else if ([UIDevice zl_isIOS8]){
        
        bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
        
    }
    else {
        //iOS6计算文字高度的方法。
        
        //        bounds.size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    }
    
    //float，向上取整 :10.3 ===> 11
    return bounds.size;
}


- (NSString *)zl_setCreatedDateFormatAt:(NSString *)createdAt
{
    // 2014-09-17 07:11:08
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //时间格式要一侄
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* createdAtDate = [dateFormatter dateFromString:createdAt];
    [dateFormatter setDateFormat:@"MM-dd"];
    
    return [dateFormatter stringFromDate:createdAtDate];
}

@end
