//
//  CustomPhotoViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "CustomPhotoViewController.h"

@interface CustomPhotoViewController ()

@end

@implementation CustomPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleView:@"相簿"];
    [self setBackButton];
    [self setRightButton];
}

- (void)titleView:(NSString *)str
{
    UILabel *labelTitle           = [[UILabel alloc] initWithFrame:CGRectZero];
    labelTitle.textColor          = kUIColorFromRGB(WHITE);
    labelTitle.font               = FONT_PING_REGULAR(16.0f);
    labelTitle.backgroundColor    = [UIColor clearColor];
    labelTitle.text               = str;
    [labelTitle sizeToFit];
    self.navigationItem.titleView = labelTitle;
}

- (void)setBackButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button setImage:[UIImage imageNamed:NAVIGATIONBAR_BACK_WIMG] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:NAVIGATIONBAR_BACK_WIMG] forState:UIControlStateHighlighted];
    button.userInteractionEnabled = YES;
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [button setTitleColor:kUIColorFromRGB(WHITE) forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_PING_REGULAR(14.0f);         //
    button.showsTouchWhenHighlighted = YES;
    button.frame = CGRectMake(0, 0, 45, 25);
    [button addTarget:self action:@selector(backActionHadAnimated) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)setRightButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:kUIColorFromRGB(WHITE) forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_PING_REGULAR(14.0f);         //
    button.showsTouchWhenHighlighted = YES;
    button.frame = CGRectMake(0, 0, 45, 25);
    [button addTarget:self action:@selector(backActionHadAnimated) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = backItem;
}


@end
