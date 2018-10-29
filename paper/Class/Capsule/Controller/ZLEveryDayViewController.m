//
//  ZLEveryDayViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLEveryDayViewController.h"
#import "ZLCapsuleTableView.h"
#import "EmptyDataCell.h"
#import "ZLCapsuleModel.h"

@interface ZLEveryDayViewController ()
{
    FMDBManager *manager;
}

@property (nonatomic, strong) NSMutableArray *everyDayArray;
@property (nonatomic, strong) EmptyDataCell *emptyCell;
@property (nonatomic,strong) ZLCapsuleTableView *capsuleTableView;

@end

@implementation ZLEveryDayViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [NSNOTIFICATION addObserver:self selector:@selector(getDataAction:) name:@"capsule_success" object:nil];
        _emptyCell = [[[NSBundle mainBundle] loadNibNamed:@"EmptyDataCell" owner:self options:nil] lastObject];
        _everyDayArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化胶囊~每天TabelView
    _capsuleTableView = [[ZLCapsuleTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-TABBAR_HEIGHT-NAVIGATIONHEIGHT) style:UITableViewStylePlain];
    _capsuleTableView.backgroundColor = kUIColorFromRGB(WHITE);
    _capsuleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_capsuleTableView];
    
    // 初始化数据库
    manager = [FMDBManager shareManager];
    [manager createCapsule];
    [self getEveryDayListData];
}

#pragma mark - 获取最新数据
- (void)getDataAction:(NSNotification *)notification
{
    [self getEveryDayListData];
}

#pragma mark - 获取插入数据库的数据
- (void)getEveryDayListData
{
    [_everyDayArray removeAllObjects];
    FMResultSet *data = [manager backCapsuleResult:@"capsule" today:0];
    while ([data next]) {
        int uid = [data intForColumn:@"uid"];
        int statusTag = [data intForColumn:@"statusTag"];
        NSString *content = [data stringForColumn:@"content"];
        NSString *cdate = [data stringForColumn:@"cdate"];
        NSString *ctime = [data stringForColumn:@"ctime"];
        NSData *img = [data dataForColumn:@"imgData"];
        ZLCapsuleModel *capsuleModel = [[ZLCapsuleModel alloc] init];
        capsuleModel.uid = uid;
        capsuleModel.statusTag = statusTag;
        capsuleModel.content = content;
        capsuleModel.cdate = cdate;
        capsuleModel.imgData = img;
        capsuleModel.ctime = ctime;
        [_everyDayArray addObject:capsuleModel];
    }
    
    if (_everyDayArray.count == 0) {
        _emptyCell.hidden = NO;
        _emptyCell.emptyNote = @"发点什么, 精彩你我!";
        [self.view addSubview:_emptyCell];
    } else {
        _emptyCell.hidden = YES;
    }
    
    self.capsuleTableView.data = _everyDayArray;
    [self.capsuleTableView reloadData];
}

@end
