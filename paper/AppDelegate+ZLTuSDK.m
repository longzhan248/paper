//
//  AppDelegate+ZLTuSDK.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "AppDelegate+ZLTuSDK.h"

#import "TuSDKFramework.h"

@implementation AppDelegate (ZLTuSDK)

- (void)initTuSdk {
    
    // 设置日志输出级别 (默认不输出)
    //    [TuSDK setLogLevel:lsqLogLevelDEBUG];
    
    [TuSDK initSdkWithAppKey:@"7fff39225edd2487-05-sv82s1"];
    
}

@end
