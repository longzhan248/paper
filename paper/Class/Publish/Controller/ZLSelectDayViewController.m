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
    
    NSString *ymdDate;
}

@property (weak, nonatomic) IBOutlet UIView *todayView;
@property (weak, nonatomic) IBOutlet UIView *futureView;

@end

@implementation ZLSelectDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _initCloseView];
    // 今天胶囊视图点击事件
    UITapGestureRecognizer *todatTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(todayAction:)];
    [_todayView addGestureRecognizer:todatTap];

    // 未来胶囊视图点击事件
    UITapGestureRecognizer *futureTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(futureAction:)];
    [_futureView addGestureRecognizer:futureTap];
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDayStr = [dateFormatter stringFromDate:date];
    
    datePicker.minLimitDate = [NSDate date:currentDayStr WithFormat:@"yyyy-MM-dd"];
    [datePicker show];
}

#pragma mark - 视图消失
- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
