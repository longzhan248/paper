//
//  ZLNoteViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLNoteViewController.h"

@interface ZLNoteViewController ()

@end

@implementation ZLNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _noteHeaderCell = [[[NSBundle mainBundle] loadNibNamed:@"ZLNoteHeaderCell" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化便签TabelView
    _noteTableView = [[ZLNoteTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-TABBAR_HEIGHT) style:UITableViewStylePlain];
    _noteTableView.backgroundColor = kUIColorFromRGB(WHITE);
    _noteTableView.backgroundColor = [UIColor clearColor];
    _noteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _noteTableView.zl_headerScaleImageHeight = NOTEHEADER_HEIGHT;
    _noteTableView.zl_headerScaleImage = [UIImage imageNamed:NOTE_TOP_BG_IMG];
    _noteTableView.tableHeaderView = _noteHeaderCell;
    [self.view addSubview:_noteTableView];
    
    // 测试数据
    _noteArray = [NSMutableArray arrayWithObjects:NOTE_PURPLE,NOTE_RED,NOTE_GREEN,NOTE_YELLOW,NOTE_PURPLE,NOTE_RED,NOTE_GREEN,NOTE_YELLOW, nil];
    
    _noteTableView.data = _noteArray;
    [_noteTableView reloadData];
}


@end
