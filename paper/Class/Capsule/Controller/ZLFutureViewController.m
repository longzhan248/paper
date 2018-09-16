//
//  ZLFutureViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLFutureViewController.h"

@interface ZLFutureViewController ()

@end

@implementation ZLFutureViewController

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
}


@end
