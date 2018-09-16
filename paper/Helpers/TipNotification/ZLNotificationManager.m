//
//  ZLNotificationManager.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLNotificationManager.h"

#define kNOTIFICATION_VIEW_HEIGHT 65

@interface ZLNotificationManager()

@property (nonatomic,readonly,getter=isShowing) BOOL showing;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *tipImageView;
@property (nonatomic,strong) UIView  *backgroundView;

@end

@implementation ZLNotificationManager

- (instancetype)init{
    if (self  = [super init]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.textColor = [UIColor whiteColor];
        
        self.textFont = FONT_PING_REGULAR(14.0f);
        self.delaySeconds = 1.0f;
        [self.backgroundView addSubview:self.titleLabel];
        [self.backgroundView addSubview:self.tipImageView];
        
        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissNotification)];
        [self.backgroundView addGestureRecognizer:dismissTap];
    }
    return self;
}

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    static id shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[super allocWithZone:NULL] init];
    });
    return shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

+ (void)setOptions:(NSDictionary *)options{
    if (!options) {
        return;
    }
    if (options[ZL_BACKGROUND_COLOR_KEY]) {
        [ZLNotificationManager shareManager].backgroundColor = options[ZL_BACKGROUND_COLOR_KEY];
    }
    if (options[ZL_TEXT_COLOR_KEY]) {
        [ZLNotificationManager shareManager].textColor = options[ZL_TEXT_COLOR_KEY];
    }
    if (options[ZL_TEXT_FONT_KEY]) {
        [ZLNotificationManager shareManager].textFont = options[ZL_TEXT_FONT_KEY];
    }
    if (options[ZL_DELAY_SECOND_KEY]){
        [ZLNotificationManager shareManager].delaySeconds = [options[ZL_DELAY_SECOND_KEY] floatValue];
    }
}

+ (void)showMessage:(NSString *)message{
    
    [ZLNotificationManager showMessage:message withOptions:nil completeBlock:nil];
}

+ (void)showMessage:(NSString *)message withOptions:(NSDictionary *)options{
    
    [ZLNotificationManager showMessage:message withOptions:options completeBlock:nil];
    
}

+ (void)showMessage:(NSString *)message withOptions:(NSDictionary *)options completeBlock:(void(^)(void))completeBlock{
    [ZLNotificationManager shareManager].completeBlock = completeBlock;
    [ZLNotificationManager setOptions:options];
    if ([[ZLNotificationManager shareManager] isShowing]) {
        [[ZLNotificationManager shareManager] reDisplayTitleLabel:message];
    }else{
        [[ZLNotificationManager shareManager] showNotification:message];
    }
}

#pragma mark - Public Methods
/**
 *  重新设置titleLabel backgroundView 背景等
 *
 *  @param message 需要显示的message
 */
- (void)setupViewOptionsWithMessage:(NSString *)message{
    self.backgroundView.backgroundColor = self.backgroundColor;
    self.titleLabel.textColor = self.textColor;
    self.titleLabel.font = self.textFont;
    self.titleLabel.text = message;
    if ([self.backgroundColor isEqual:WARNNING_COLOR]) {
        self.tipImageView.image = [UIImage imageNamed:@"warning"];
    }else if ([self.backgroundColor isEqual:TIP_COLOR]){
        self.tipImageView.image = [UIImage imageNamed:@"tips"];
    }else{
        self.tipImageView.image = [UIImage imageNamed:@"share_success"];
    }
}

/**
 *  显示一条消息通知
 *
 *  @param message 需要显示的信息
 */
- (void)showNotification:(NSString *)message{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissNotification) object:nil];
    self.backgroundView.frame = CGRectMake(0, -kNOTIFICATION_VIEW_HEIGHT, self.backgroundView.frame.size.width, kNOTIFICATION_VIEW_HEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.backgroundView];
    [self setupViewOptionsWithMessage:message];
    [self resizeTitleLabelFrame];
    [self resizeTitleImgFrame];
    [UIView animateWithDuration:.5 animations:^{
        self.backgroundView.frame = CGRectMake(0, 0, self.backgroundView.frame.size.width, kNOTIFICATION_VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dismissNotification) withObject:nil afterDelay:self.delaySeconds];
    }];
}

#pragma mark - Private Methods
/**
 *  当消息通知已经显示时  重新显示titleLabel
 *
 *  @param message 需要显示的消息
 */
- (void)reDisplayTitleLabel:(NSString *)message{
    //取消之前通知隐藏notification
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissNotification) object:nil];
    [UIView animateWithDuration:.2 animations:^{
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, kNOTIFICATION_VIEW_HEIGHT + 10, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    } completion:^(BOOL finished) {
        [self setupViewOptionsWithMessage:message];
        [self resizeTitleLabelFrame];
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, -10, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
        [UIView animateWithDuration:.1 animations:^{
            [self resizeTitleLabelFrame];
        } completion:^(BOOL finished) {
            //重新定义调用延迟隐藏notification
            [self performSelector:@selector(dismissNotification) withObject:nil afterDelay:self.delaySeconds];
        }];
    }];
}

- (void)resizeTitleLabelFrame{
    
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.size = [self.titleLabel sizeThatFits:CGSizeMake([UIScreen mainScreen].applicationFrame.size.width - 40, 36)];
    titleFrame.origin = CGPointMake(45, self.backgroundView.frame.size.height/2 - titleFrame.size.height/2 + 5);
    self.titleLabel.frame = titleFrame;
}

- (void)resizeTitleImgFrame{
    
    CGRect imgFrame = self.tipImageView.frame;
    imgFrame.size = [self.tipImageView sizeThatFits:CGSizeMake(16, 14)];
    imgFrame.origin = CGPointMake(20, self.backgroundView.frame.size.height/2 - imgFrame.size.height/2 + 5);
    self.tipImageView.frame = imgFrame;
}

/**
 *  隐藏通知
 */
- (void)dismissNotification{
    if (!self.showing) {
        return;
    }
    [UIView animateWithDuration:.5 animations:^{
        self.backgroundView.frame = CGRectMake(0, -kNOTIFICATION_VIEW_HEIGHT, self.backgroundView.frame.size.width, kNOTIFICATION_VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        if (self.completeBlock) {
            self.completeBlock();
            self.completeBlock = nil;
        }
    }];
}

- (UIImageView *)tipImageView
{
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _tipImageView;
}

- (BOOL)isShowing{
    return self.backgroundView && self.backgroundView.superview;
}

@end
