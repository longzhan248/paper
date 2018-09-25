//
//  ZLSelectDayViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/21.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLSelectDayViewController.h"
#import "ZLSelectCapsuleViewController.h"
#import "XHDatePickerView.h"
#import "NSDate+ZLExtension.h"

@interface ZLSelectDayViewController ()
{
    UIButton *closeButton;
    
    FMDBManager *manager;
}

@property (weak, nonatomic) IBOutlet UIView *todayView;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayTipLabel;

@property (weak, nonatomic) IBOutlet UIView *futureView;

@end

@implementation ZLSelectDayViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [NSNOTIFICATION addObserver:self selector:@selector(dismissAction:) name:@"capsule_success" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _initCloseView];
    // 今天胶囊视图点击事件
    UITapGestureRecognizer *todatTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(todayAction:)];
    [_todayView addGestureRecognizer:todatTap];

    // 未来胶囊视图点击事件
    UITapGestureRecognizer *futureTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(futureAction:)];
    [_futureView addGestureRecognizer:futureTap];
    
    // 取出最新发出的一条胶囊判断今天是否已经发过胶囊，每天只能发一个胶囊。
    manager = [FMDBManager shareManager];
    [manager createCapsule];
    FMResultSet *data = [manager selectFind:@"capsule"];
    while ([data next]) {
        NSString *cdate = [data stringForColumn:@"cdate"];
        
        if ([cdate isEqualToString:[CommonUtil getLocalTime]]) {
            _todayView.userInteractionEnabled = NO;
            _todayLabel.textColor = kUIColorFromRGB(GRAY);
            _todayTipLabel.textColor = kUIColorFromRGB(GRAY);
        } else
            _todayView.userInteractionEnabled = YES;
            _todayLabel.textColor = kUIColorFromRGB(CAPLUSE_COLOR);
            _todayTipLabel.textColor = kUIColorFromRGB(DETAIL_COLOR);
    }
}

- (void)_initCloseView {
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0, 20, 60, 60);
    closeButton.imageEdgeInsets = UIEdgeInsetsMake(5, -30, 0, 0);
    [closeButton setImage:[UIImage imageNamed:@"publish_note_close"] forState:UIControlStateNormal];
    closeButton.showsTouchWhenHighlighted = YES;
    [closeButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleft = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItem = barleft;
}

#pragma mark - 今天点击事件
- (void)todayAction:(UITapGestureRecognizer *)sender {
    ZLSelectCapsuleViewController *selectCapsuleCtrl = [[ZLSelectCapsuleViewController alloc] init];
    [self.navigationController pushViewController:selectCapsuleCtrl animated:YES];
}

- (void)futureAction:(UITapGestureRecognizer *)sender {
    XHDatePickerView *datePicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate, NSDate *endDate) {
        ZLSelectCapsuleViewController *selectCapsuleCtrl = [[ZLSelectCapsuleViewController alloc] init];
        selectCapsuleCtrl.selectTime = ymdDate;
        [self.navigationController pushViewController:selectCapsuleCtrl animated:YES];
    }];
    
    datePicker.datePickerStyle = DateStyleShowYearMonthDay;
    datePicker.dateType = DateTypeStartDate;
    
    NSDate *date = [NSDate date];//当前时间
    NSString *currentDayStr = [CommonUtil getTomorrowDay:date];
    
    datePicker.minLimitDate = [NSDate date:currentDayStr WithFormat:@"yyyy-MM-dd"];
    [datePicker show];
}

#pragma mark - 视图消失
- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 通知
- (void)dismissAction:(NSNotification *)notification
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
