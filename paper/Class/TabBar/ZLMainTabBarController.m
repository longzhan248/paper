//
//  ZLMainTabBarController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLMainTabBarController.h"

#import "ZLNoteViewController.h"
#import "ZLCapsuleViewController.h"
#import "ZLPublishViewController.h"
#import "ZLTargetViewController.h"
#import "ZLSettingViewController.h"

#import "ZLPublishNoteViewController.h"


@interface ZLMainTabBarController ()

@end

@implementation ZLMainTabBarController

- (void)dealloc
{
    [NSNOTIFICATION removeObserver:self name:@"skip_controller" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSNOTIFICATION addObserver:self selector:@selector(skipController:) name:@"skip_controller" object:nil];

    
    [self _initController];
}

- (void)_initController
{
    ZLNoteViewController *notectrl = [[ZLNoteViewController alloc] init];
    ZLCapsuleViewController *capsuleCtrl = [[ZLCapsuleViewController alloc] init];
    ZLPublishViewController *publishCtrl = [[ZLPublishViewController alloc] init];
    ZLTargetViewController *targetCtrl = [[ZLTargetViewController alloc] init];
    ZLSettingViewController *settingCtrl = [[ZLSettingViewController alloc] init];
    
    NSArray *arrayViews = @[notectrl,capsuleCtrl,publishCtrl,targetCtrl,settingCtrl];
    
    viewControllers = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in arrayViews) {
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:viewController];
        [viewControllers addObject:baseNav];
        baseNav.delegate = self;
    }
    self.viewControllers = viewControllers;
    self.selectedIndex = 0;
}

#pragma mark - UINavigationController delegate
// 监听五个导航控制器的push事件
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //导航控制器子控制器的个数
    NSInteger count = navigationController.viewControllers.count;
    if (count == 2) {
        [self showTabbar:NO];
    }else if(count == 1){
        [self showTabbar:YES];
    }
}

#pragma mark - 跳转发布视图控制器
- (void)skipController:(NSNotification *)notification
{
    NSString *firstIndex = [notification object];
    if ([firstIndex isEqualToString:@"0"]) {
        ZLPublishNoteViewController *markDown = [[ZLPublishNoteViewController alloc] init];
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:markDown];
        baseNav.canDragBack = NO;
        [self presentViewController:baseNav animated:YES completion:nil];
    }
}

@end
