//
//  PopMenuModel.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "PopMenuModel.h"
#import "PopMenuButton.h"

@implementation PopMenuModel

+ (instancetype __nonnull)allocPopMenuModelWithImageNameString:(NSString* __nonnull)imageNameString

                                                 AtTitleString:(NSString* __nonnull)titleString

                                                   AtTextColor:(UIColor* __nonnull)textColor

                                              AtTransitionType:(PopMenuTransitionType)transitionType

                                    AtTransitionRenderingColor:(UIColor* __nullable)transitionRenderingColor
{
    PopMenuModel* model = [[PopMenuModel alloc] init];
    model.imageNameString = imageNameString;
    model.titleString = titleString;
    model.transitionType = transitionType;
    model.transitionRenderingColor = transitionRenderingColor;
    model.textColor = textColor;
    [model _obj];
    return model;
}

- (instancetype __nonnull)init
{
    self = [super init];
    if (self) {
        self.transitionType = PopMenuTransitionTypeSystemApi;
    }
    return self;
}

- (void)setAutomaticIdentificationColor:(BOOL)automaticIdentificationColor
{
    _automaticIdentificationColor = automaticIdentificationColor;
    [_customView setValue:self forKey:@"model"];
}

- (void)_obj
{
    PopMenuButton* button = [[PopMenuButton alloc] init];
    button.model = self;
    CGFloat buttonViewWidth = MIN(92, 92);
    buttonViewWidth = buttonViewWidth - 10;
    button.bounds = CGRectMake(0, -15, buttonViewWidth, buttonViewWidth);
    _customView = button;
}

@end
