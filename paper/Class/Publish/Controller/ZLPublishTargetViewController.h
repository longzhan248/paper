//
//  ZLPublishTargetViewController.h
//  paper
//
//  Created by 詹龙 on 2018/9/26.
//  Copyright © 2018 longzhan. All rights reserved.
//

#import "BaseViewController.h"

@class ZLTargetModel;

@protocol UpdateDelegate <NSObject>

//代理
- (void)updateTarget:(ZLTargetModel *)targetModel;

@end

@interface ZLPublishTargetViewController : BaseViewController

@property (nonatomic, strong) ZLTargetModel *targetModel;

@property (nonatomic, weak) id<UpdateDelegate> delegate;

@end
