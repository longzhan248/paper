//
//  ZLTargetViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLTargetViewController.h"

@interface ZLTargetViewController ()

@end

@implementation ZLTargetViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setNavigationTitle:ZLLangaueStr(@"TBTarget")];
    
}


@end
