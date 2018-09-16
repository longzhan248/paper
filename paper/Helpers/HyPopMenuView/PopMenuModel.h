//
//  PopMenuModel.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PopMenuTransitionTypeSystemApi,
    PopMenuTransitionTypeCustomizeApi,
} PopMenuTransitionType;

@interface PopMenuModel : NSObject

@property (nonatomic, assign) BOOL automaticIdentificationColor;

@property (nonatomic, copy, nonnull) NSString* imageNameString;

@property (nonatomic, copy, nonnull) NSString* titleString;

@property (nonatomic, weak, nullable) UIColor* transitionRenderingColor;

@property (nonatomic, weak, nullable) UIColor* textColor;

@property (nonatomic, assign) PopMenuTransitionType transitionType;

@property (nonatomic, readonly, retain, nonnull) UIView* customView;

+ (instancetype __nonnull)allocPopMenuModelWithImageNameString:(NSString* __nonnull)imageNameString

                                                 AtTitleString:(NSString* __nonnull)titleString

                                                   AtTextColor:(UIColor* __nonnull)textColor

                                              AtTransitionType:(PopMenuTransitionType)transitionType

                                    AtTransitionRenderingColor:(UIColor* __nullable)transitionRenderingColor;

@end
