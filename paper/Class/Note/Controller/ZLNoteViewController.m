//
//  ZLNoteViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLNoteViewController.h"

@interface ZLNoteViewController () <deleteUpdateDelegate>

@end

@implementation ZLNoteViewController

- (void)dealloc
{
    [NSNOTIFICATION removeObserver:self name:@"publish_success" object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _noteHeaderCell = [[[NSBundle mainBundle] loadNibNamed:@"ZLNoteHeaderCell" owner:self options:nil] lastObject];
        _emptyCell = [[[NSBundle mainBundle] loadNibNamed:@"EmptyDataCell" owner:self options:nil] lastObject];
        [NSNOTIFICATION addObserver:self selector:@selector(getDataAction:) name:@"publish_success" object:nil];

        _noteArray = [NSMutableArray array];

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
    
    //初始化便签TabelView
    _noteTableView = [[ZLNoteTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-TABBAR_HEIGHT) style:UITableViewStylePlain];
    _noteTableView.backgroundColor = kUIColorFromRGB(WHITE);
    _noteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _noteTableView.deleteDelegate = self;
    //初始化便签tableHeaderView
    _noteTableView.zl_headerScaleImageHeight = NOTEHEADER_HEIGHT;
    _noteTableView.zl_headerScaleImage = [UIImage imageNamed:NOTE_TOP_BG_IMG];
    
    UIView *bgView = [UIView new];
    _noteHeaderCell.width = ScreenWidth;
    bgView.frame = CGRectMake(0, 0, ScreenWidth, NOTEHEADER_HEIGHT+NOTEBGCELL_PADDING_HEIGHT);
    [bgView addSubview:_noteHeaderCell];
    
    _noteTableView.tableHeaderView = bgView;
    
    [self.view addSubview:_noteTableView];
    
    //初始化数据库
    manager = [[FMDBManager alloc]init];
    [FMDBManager shareManager];
    [self getNoteListData];

}

#pragma mark - 删除后同步数据
- (void)updateDelete {
    [self getNoteListData];
}

#pragma mark - 获取最新数据
- (void)getDataAction:(NSNotification *)notification
{
    [self getNoteListData];
}

#pragma mark - 获取插入数据库的数据
- (void)getNoteListData {
    
    [_noteArray removeAllObjects];
    FMResultSet *data = [manager backResults:@"note"];
    while ([data next]) {
        int uid = [data intForColumn:@"uid"];
        NSString *content = [data stringForColumn:@"content"];
        int colorTag = [data intForColumn:@"colorTag"];
        int width = [data intForColumn:@"width"];
        int height = [data intForColumn:@"height"];
        NSString *ctime = [data stringForColumn:@"ctime"];
        NSData *img = [data dataForColumn:@"imgData"];
        ZLNoteModel *noteModel = [[ZLNoteModel alloc] init];
        noteModel.uid = uid;
        noteModel.content = content;
        noteModel.colorTag = colorTag;
        noteModel.width = width;
        noteModel.height = height;
        noteModel.imgData = img;
        noteModel.ctime = ctime;
        [_noteArray addObject:noteModel];
    }
    
    if (_noteArray.count==0) {
        _emptyCell.hidden = NO;
        _emptyCell.emptyNote = @"发点什么，精彩你我！";
        [self.view addSubview:_emptyCell];
    }else{
        _emptyCell.hidden = YES;
    }
    
    _noteHeaderCell.totalLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_noteArray.count];
    self.noteTableView.data = _noteArray;
    [self .noteTableView reloadData];
}

@end
