//
//  ZLSelectCapsuleViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/21.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLSelectCapsuleViewController.h"
#import "ZLPublishCapsuleViewController.h"

@interface ZLSelectCapsuleViewController ()

@property (weak, nonatomic) IBOutlet UIView *calmView;
@property (weak, nonatomic) IBOutlet UIView *prettyView;
@property (weak, nonatomic) IBOutlet UIView *badView;

@end

@implementation ZLSelectCapsuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_selectTime==nil||[_selectTime isEqualToString:@""]) {
        [super setNavigationTitle:@"今天"];
    } else {
        [super setNavigationTitle:_selectTime];
    }
    
    // 平静的一天
    UITapGestureRecognizer *calmTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(calmAction:)];
    [_calmView addGestureRecognizer:calmTap];
    
    // 不错的一天
    UITapGestureRecognizer *prettyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prettyAction:)];
    [_prettyView addGestureRecognizer:prettyTap];
    
    // 难过的一天
    UITapGestureRecognizer *badTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(badAction:)];
    [_badView addGestureRecognizer:badTap];
}

#pragma mark - 平静的一天点击事件
- (void)calmAction:(UITapGestureRecognizer *)sender
{
    ZLPublishCapsuleViewController *publishCapsuleCtrl = [[ZLPublishCapsuleViewController alloc] init];
    publishCapsuleCtrl.futureTime = _selectTime;
    publishCapsuleCtrl.statusTag = 0;
    [self.navigationController pushViewController:publishCapsuleCtrl animated:YES];
}

#pragma mark - 不错的一天点击事件
- (void)prettyAction:(UITapGestureRecognizer *)sender
{
    ZLPublishCapsuleViewController *publishCapsuleCtrl = [[ZLPublishCapsuleViewController alloc] init];
    publishCapsuleCtrl.futureTime = _selectTime;
    publishCapsuleCtrl.statusTag = 1;
    [self.navigationController pushViewController:publishCapsuleCtrl animated:YES];
}

#pragma mark - 难过的一天点击事件
- (void)badAction:(UITapGestureRecognizer *)sender
{
    ZLPublishCapsuleViewController *publishCapsuleCtrl = [[ZLPublishCapsuleViewController alloc] init];
    publishCapsuleCtrl.futureTime = _selectTime;
    publishCapsuleCtrl.statusTag = 2;
    [self.navigationController pushViewController:publishCapsuleCtrl animated:YES];
}

@end
