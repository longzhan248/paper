//
//  ZLNoteDetailViewController.h
//  paper
//
//  Created by 詹龙 on 2018/9/18.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "BaseViewController.h"

@class ZLNoteModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZLNoteDetailViewController : BaseViewController

@property (nonatomic, strong) ZLNoteModel *noteModel;

@end

NS_ASSUME_NONNULL_END
