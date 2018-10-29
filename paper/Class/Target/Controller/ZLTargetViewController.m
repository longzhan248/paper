//
//  ZLTargetViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLTargetViewController.h"
#import "ZLTargetTableView.h"
#import "EmptyDataCell.h"
#import "ZLTargetCell.h"
#import "CountTimer.h"
#import "CountDown.h"

@interface ZLTargetViewController ()
{
    FMDBManager *manager;
}

@property (nonatomic, strong) CountDown *countDown;
@property (nonatomic, strong) ZLTargetTableView *targetTableView;
@property (nonatomic, strong) NSMutableArray *targetArray;
@property (nonatomic, strong) EmptyDataCell *emptyCell;

@end

@implementation ZLTargetViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _targetArray = [NSMutableArray array];
        
        [NSNOTIFICATION addObserver:self selector:@selector(getDataAction:) name:@"target_success" object:nil];
    }
    return self;
}

- (void)dealloc {
    [NSNOTIFICATION removeObserver:self name:@"target_success" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)updateTimeInVisibleCells{
    NSArray  *cells = self.targetTableView.visibleCells; //取出屏幕可见ceLl
    for (ZLTargetCell *cell in cells) {
        ZLTargetModel *targetModel = _targetArray[cell.tag];
        cell.timeLabel.text = [[CountTimer shareInstance] getNowTimeWithString:targetModel.endHDate];
        if ([cell.timeLabel.text isEqualToString:@"目标已过期"]) {
            cell.timeLabel.textColor = kUIColorFromRGB(0XFA5133);
        }else{
            cell.timeLabel.textColor = kUIColorFromRGB(MAIN_COLOR);
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setNavigationTitle:ZLLangaueStr(@"TBTarget")];
    
    // 初始化目标TableView
    _targetTableView = [[ZLTargetTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-TABBAR_HEIGHT-NAVIGATIONHEIGHT) style:UITableViewStylePlain];
    _targetTableView.backgroundColor = kUIColorFromRGB(WHITE);
    _targetTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_targetTableView];
    
    // 初始化数据库
    manager = [FMDBManager shareManager];
    [manager createTarget];
    [self getTargetListData];
    
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf = self;
    /// 每一秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        [weakSelf updateTimeInVisibleCells];
    }];
}

#pragma mark - 获取最新数据
- (void)getDataAction:(NSNotification *)notification {
    [self getTargetListData];
}

#pragma mark - 获取插入数据库的数据
- (void)getTargetListData {
    // FMDB动态实现今天发布目标的功能
    [_targetArray removeAllObjects];
    FMResultSet *data = [manager backTargetDataWithModel:@"target"];
    while ([data next]) {
        int uid = [data intForColumn:@"uid"];
        int statusTag = [data intForColumn:@"statusTag"];
        NSString *content = [data stringForColumn:@"content"];
        NSString *title = [data stringForColumn:@"title"];
        NSString *endDate = [data stringForColumn:@"endDate"];
        NSString *ctime = [data stringForColumn:@"ctime"];
        ZLTargetModel *targetModel = [[ZLTargetModel alloc] init];
        targetModel.uid = uid;
        targetModel.statusTag = statusTag;
        targetModel.title = title;
        targetModel.content = content;
        targetModel.endDate = endDate;
        targetModel.ctime = ctime;
        [_targetArray addObject:targetModel];
    }
    
    if (0 == _targetArray.count) {
        _emptyCell.hidden = NO;
        _emptyCell.emptyTarget = @"发点什么, 精彩你我!";
        [self.view addSubview:_emptyCell];
    } else {
        _emptyCell.hidden = YES;
    }
    
    self.targetTableView.data = _targetArray;
    [self.targetTableView reloadData];
    
}


@end
