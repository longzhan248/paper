//
//  ZLFutureViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLFutureViewController.h"
#import "ZLCapsuleTableView.h"
#import "EmptyDataCell.h"


@interface ZLFutureViewController ()
{
    FMDBManager *manager;
}

@property (nonatomic,strong) NSMutableArray *futureArray;
@property (nonatomic,strong) EmptyDataCell *emptyCell;
@property (nonatomic,strong) ZLCapsuleTableView *capsuleTableView;

@end

@implementation ZLFutureViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [NSNOTIFICATION addObserver:self selector:@selector(getDataAction:) name:@"capsule_success" object:nil];
        _emptyCell = [[[NSBundle mainBundle] loadNibNamed:@"EmptyDataCell" owner:self options:nil] lastObject];
        _futureArray = [NSMutableArray array];
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
    
    //初始化胶囊~未来TabelView
    _capsuleTableView = [[ZLCapsuleTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-TABBAR_HEIGHT-NAVIGATIONHEIGHT) style:UITableViewStylePlain];
    _capsuleTableView.backgroundColor = kUIColorFromRGB(WHITE);
    _capsuleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_capsuleTableView];
    
    //初始化数据库
    manager = [FMDBManager shareManager];
    [manager createCapsule];
    [self getFutureListData];
}

#pragma mark - 获取最新数据
- (void)getDataAction:(NSNotification *)notification
{
    [self getFutureListData];
}

#pragma mark - 获取插入数据库的数据
- (void)getFutureListData
{
    [_futureArray removeAllObjects];
    FMResultSet *data = [manager backCapsuleResult:@"capsule" today:1];
    while ([data next]) {
        int uid = [data intForColumn:@"uid"];
        int statusTag = [data intForColumn:@"statusTag"];
        NSString *content = [data stringForColumn:@"content"];
        NSString *cdate = [data stringForColumn:@"cdate"];
        NSString *ctime = [data stringForColumn:@"ctime"];
        NSData *img = [data dataForColumn:@"imgData"];
        ZLCapsuleModel *capsuleModel = [[ZLCapsuleModel alloc] init];
        capsuleModel.uid = uid;
        capsuleModel.content = content;
        capsuleModel.statusTag = statusTag;
        capsuleModel.cdate = cdate;
        capsuleModel.imgData = img;
        capsuleModel.ctime = ctime;
        [_futureArray addObject:capsuleModel];
    }
    
    if (_futureArray.count==0) {
        _emptyCell.hidden = NO;
        _emptyCell.emptyNote = @"发点什么，精彩你我！";
        [self.view addSubview:_emptyCell];
    }else{
        _emptyCell.hidden = YES;
    }
    
    self.capsuleTableView.data = _futureArray;
    [self .capsuleTableView reloadData];
}

@end
