//
//  EmptyDataCell.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "EmptyDataCell.h"

@implementation EmptyDataCell

- (void)setEmptyNote:(NSString *)emptyNote
{
    self.width = ScreenWidth;
    self.top = (ScreenHeight-100)/2;
}

- (void)setEmptyCapsule:(NSString *)emptyCapsule {
    self.width = ScreenWidth;
    self.top = (ScreenHeight-260)/2;
}

- (void)setEmptyTarget:(NSString *)emptyTarget {
    [self setEmptyCapsule:emptyTarget];
}

@end
