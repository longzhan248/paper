//
//  ZLPublishCapsuleViewController.h
//  paper
//
//  Created by 詹龙 on 2018/9/21.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "BaseViewController.h"

@class ZLCapsuleModel;

@interface ZLPublishCapsuleViewController : BaseViewController

@property (nonatomic, assign) int statusTag;

@property (nonatomic, copy) NSString *futureTime;
@property (nonatomic, copy) NSString *skip;

@property (nonatomic, strong) ZLCapsuleModel *capsuleModel;

@end
