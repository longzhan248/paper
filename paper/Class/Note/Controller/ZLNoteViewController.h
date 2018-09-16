//
//  ZLNoteViewController.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "BaseViewController.h"
#import "ZLNoteHeaderCell.h"
#import "ZLNoteTableView.h"
#import "UIScrollView+ZLHeaderScaleImage.h"
#import "ZLNoteModel.h"
#import "EmptyDataCell.h"

@interface ZLNoteViewController : BaseViewController
{
    FMDBManager *manager;
}

@property (nonatomic,strong) EmptyDataCell *emptyCell;

@property (nonatomic,strong) ZLNoteTableView  *noteTableView;
@property (nonatomic,strong) ZLNoteHeaderCell *noteHeaderCell;

@property (nonatomic,strong) NSMutableArray *noteArray;


@end
