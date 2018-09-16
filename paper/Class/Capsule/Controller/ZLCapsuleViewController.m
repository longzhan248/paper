//
//  ZLCapsuleViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLCapsuleViewController.h"
#import "ZLEveryDayViewController.h"
#import "ZLFutureViewController.h"

@interface ZLCapsuleViewController ()

@end

@implementation ZLCapsuleViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setNavigationTitle:ZLLangaueStr(@"TBCapsule")];

    TabPageView *pageView = [[TabPageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withTitles:@[@"每天",@"未来"] withViewControllers:@[@"ZLEveryDayViewController",@"ZLFutureViewController"] withParameters:nil];
    pageView.pageViewStyle = HYPageViewStyleB;
    
    pageView.isAnimated = YES;
    pageView.selectedColor = kUIColorFromRGB(CAPSULE_BLUE_CLOR);
    pageView.unselectedColor = kUIColorFromRGB(CAPSULE_TOP);
    pageView.font = FONT_PING_REGULAR(16.0f);
    pageView.defaultSubscript = 0;
    
    [self.view addSubview:pageView];
}


@end
