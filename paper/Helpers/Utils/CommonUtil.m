//
//  CommonUtil.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "CommonUtil.h"

#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) lastObject]


@implementation CommonUtil

+ (id)shareInstance {
    static CommonUtil *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[super allocWithZone:NULL] init];
    });
    return singleton;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

+(void)registerNotice:(NSString *)keyString object:(NSObject*)object
{
    [[NSNotificationCenter defaultCenter] postNotificationName:keyString object:object];
}

@end
