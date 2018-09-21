//
//  ZLPublishCapsuleViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/21.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLPublishCapsuleViewController.h"
#import "PlaceholderTextView.h"

@interface ZLPublishCapsuleViewController () <UITextViewDelegate>
{
    UIButton *publishButton;
}

@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;

@end

@implementation ZLPublishCapsuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setNavigationTitle:@"发布胶囊"];

    [self _initPublishButton];
}

#pragma mark - 代码方式发布入口
- (void)_initPublishButton
{
    _textView.placeholder = @"写你所想...";
    _textView.delegate = self;
    _textView.placeholderFont = FONT_PING_REGULAR(12.0f);
    
    publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.frame = CGRectMake(0, 25, 40, 40);
    [publishButton setImage:[UIImage imageNamed:@"publish_note"] forState:UIControlStateNormal];
    publishButton.showsTouchWhenHighlighted = YES;
    [publishButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barright = [[UIBarButtonItem alloc] initWithCustomView:publishButton];
    self.navigationItem.rightBarButtonItem = barright;
}

#pragma mark - 发布事件
- (void)sendAction:(UIButton *)sender
{
    
}

@end
