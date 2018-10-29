//
//  ZLNoteTableView.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "BaseTableView.h"
#import "ZLNoteCell.h"
#import "ZLNoteModel.h"

@protocol deleteUpdateDelegate <NSObject>

- (void)updateDelete;

@end

@interface ZLNoteTableView : BaseTableView

@property (nonatomic,weak) id <deleteUpdateDelegate> deleteDelegate;

@property (nonatomic,strong) ZLNoteCell *noteCell;

@end
