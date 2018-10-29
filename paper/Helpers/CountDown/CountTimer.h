//
//  CountTimer.h
//  paper
//
//  Created by apple on 2018/10/26.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountTimer : NSObject

+ (id)shareInstance;

- (NSString *)getNowTimeWithString:(NSString *)aTimeString;

@end

