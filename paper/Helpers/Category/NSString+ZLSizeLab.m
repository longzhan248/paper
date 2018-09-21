//
//  NSString+ZLSizeLab.m
//  paper
//
//  Created by 詹龙 on 2018/9/18.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "NSString+ZLSizeLab.h"
#import "UIDevice+ZLLigs.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

@implementation NSString (ZLSizeLab)

- (CGSize)zl_heightWithFont:(UIFont* )font width:(CGFloat)width {
    CGRect bounds = CGRectZero;
    
    //UIDevic的类别，用来判断是否是iOS7
    if ([UIDevice zl_isIOS7]) {
        //iOS7计算文字高度的方法。
        bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
    }else if ([UIDevice zl_isIOS8]){
        
        bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
    }
    else {
        //iOS6计算文字高度的方法。
        
        bounds.size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    }
    
    //float，向上取整 :10.3 ===> 11
    return bounds.size;
}

- (NSAttributedString *)zl_LabelContent:(NSString *)content{
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 5.0f;
    NSDictionary * attributes = @{NSFontAttributeName : FONT_PING_REGULAR(16.0f),
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    attributes = @{NSFontAttributeName:FONT_PING_REGULAR(16.0f), NSParagraphStyleAttributeName:paragraphStyle};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    
    return attributedString;
}

@end
