//
//  BaseViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "BaseViewController.h"
#define kRotationDuration 8.0

#define NavBarFrame self.navigationController.navigationBar.frame

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackButton = YES;
        self.isRight = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

#pragma mark - 成为第一响应者
-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kUIColorFromRGB(BG_COLOR);
    [self navigationBackView];
}

#pragma mark - 导航栏返回
- (void)navigationBackView {
    NSArray *viewController = self.navigationController.viewControllers;
    NSLog(@"viewController:%lu",(unsigned long)viewController.count);
    if (viewController.count > 1 && self.isBackButton) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:NAVIGATIONBAR_BACK_IMG] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:NAVIGATIONBAR_BACK_IMG] forState:UIControlStateHighlighted];
        button.userInteractionEnabled = YES;
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.showsTouchWhenHighlighted = YES;
        button.frame = CGRectMake(0, 0, 45, 25);
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}

#pragma mark - override 设置导航栏字体的属性
- (void) setNavigationTitle:(NSString *)title
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth-180)/2, 0, 180, 20)];
    
    UILabel *labelTitle           = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 20)];
    labelTitle.textColor          = kUIColorFromRGB(BLACK);
    labelTitle.font               = FONT_PING_REGULAR(16);
    labelTitle.textAlignment      = NSTextAlignmentCenter;
    labelTitle.backgroundColor    = [UIColor clearColor];
    labelTitle.text               = title;
    [titleView addSubview:labelTitle];
    
    self.navigationItem.titleView = titleView;
}

- (void)setNavigationWTitle:(NSString *)title
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth-100)/2, 0, 100, 20)];
    
    UILabel *labelTitle           = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    labelTitle.textColor          = kUIColorFromRGB(WHITE);
    labelTitle.font               = FONT_PING_REGULAR(16);
    labelTitle.textAlignment      = NSTextAlignmentCenter;
    labelTitle.backgroundColor    = [UIColor clearColor];
    labelTitle.text               = title;
    [titleView addSubview:labelTitle];
    
    self.navigationItem.titleView = titleView;
}

#pragma mark - override 设置导航栏图片
- (void) setNavigationImg:(UIImage *)image
{
    UIImageView *imageView        = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.frame               = CGRectMake(0, 0, 63, 23);
    imageView.backgroundColor     = [UIColor clearColor];
    imageView.contentMode         = UIViewContentModeScaleAspectFit;
    imageView.image               = image;
    self.navigationItem.titleView = imageView;
}

#pragma mark -actions
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
