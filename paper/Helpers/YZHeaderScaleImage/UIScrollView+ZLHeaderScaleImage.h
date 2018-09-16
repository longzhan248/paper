//
//  UIScrollView+ZLHeaderScaleImage.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ZLHeaderScaleImage)

/**
 *  头部缩放视图图片
 */
@property (nonatomic, strong) UIImage *zl_headerScaleImage;

/**
 *  头部缩放视图图片高度
 */
@property (nonatomic, assign) CGFloat zl_headerScaleImageHeight;

@property (nonatomic,strong) NSString *headStr;

@end
