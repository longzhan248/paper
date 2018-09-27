//
//  ZLPublishTargetViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/26.
//  Copyright © 2018 longzhan. All rights reserved.
//

#import "ZLPublishTargetViewController.h"
#import "PlaceholderTextView.h"
#import "XHDatePickerView.h"
#import "NSDate+ZLExtension.h"

@interface ZLPublishTargetViewController () <UITextViewDelegate>
{
    UIButton *closeButton;
    UILabel *titleLabel;
    UIButton *publishButton;
    
    NSString *ymdDate;
}

@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ZLPublishTargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setNavigationTitle:@"发布目标"];
    [self _initBackAndPublishButton];
    
    // 截止日期点击事件
    UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateAction:)];
    [_dateView addGestureRecognizer:dateTap];
}

#pragma mark - 代码方式实现返回和发布入口
- (void)_initBackAndPublishButton {
    _textView.placeholder = @"写你所想...";
    _textView.delegate = self;
    _textView.placeholderFont = FONT_PING_REGULAR(12.0f);
    
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0, 20, 60, 60);
    closeButton.imageEdgeInsets = UIEdgeInsetsMake(5, -30, 0, 0);
    [closeButton setImage:[UIImage imageNamed:@"publish_note_close"] forState:UIControlStateNormal];
    closeButton.showsTouchWhenHighlighted = YES;
    [closeButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleft = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItem = barleft;
    
    publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.frame = CGRectMake(0, 25, 40, 40);
    [publishButton setImage:[UIImage imageNamed:@"publish_note"] forState:UIControlStateNormal];
    publishButton.showsTouchWhenHighlighted = YES;
    [publishButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barright = [[UIBarButtonItem alloc] initWithCustomView:publishButton];
    self.navigationItem.rightBarButtonItem = barright;
}

#pragma mark - 视图消失
- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 发布事件
- (void)sendAction:(UIButton *)sender
{
}

#pragma mark - UITextView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger res = 140-[new length];
    _numLabel.text = [NSString stringWithFormat:@"%d字",(int)res];
    if(res >= 0){
        return YES;
    }else{
        if (res<0) {
            _numLabel.text = [NSString stringWithFormat:@"0字"];
            _textView.text = [new substringToIndex:140];
            return NO;
        }
        return NO;
    }
}

- (void)dateAction:(UITapGestureRecognizer *)sender
{
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate,NSDate *endDate) {
        ymdDate = [startDate stringWithFormat:@"yyyy-MM-dd"];
        _dateLabel.text = ymdDate;
    }];
    datepicker.datePickerStyle = DateStyleShowYearMonthDay;
    datepicker.dateType = DateTypeStartDate;
    
    NSDate * date = [NSDate date];//当前时间
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDayStr = [dateFormatter stringFromDate:date];
    
    datepicker.minLimitDate = [NSDate date:currentDayStr WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}


@end