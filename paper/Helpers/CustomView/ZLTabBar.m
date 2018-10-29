//
//  ZLTabBar.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLTabBar.h"
#import "ZLButton.h"

@interface ZLTabBar ()

//选中的图片
@property (nonatomic,strong) ZLButton *selectBtn;

@end

@implementation ZLTabBar

+ (instancetype)buttonView{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [ super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    NSArray *imagesArray = TABBAR_IMG;
    NSArray *imagesSelectArray = TABBAR_SELECT_IMG;
    for (NSInteger index = 0; index <imagesArray.count; index++) {
        ZLButton *btn = [ZLButton buttonWithType:UIButtonTypeCustom];
        UIImage *normalImg = [UIImage imageNamed:imagesArray[index]];
        UIImage *selectImg = [UIImage imageNamed:imagesSelectArray[index]];
        [btn setImage:selectImg forState:UIControlStateSelected];
        [btn setImage:normalImg forState:UIControlStateNormal];
        //标记
        btn.tag = index;
        //监听点击
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        //默认选中第一个
        if (index == 0) {
            self.selectBtn = btn;
            self.selectBtn.selected = YES;
        }
    }
}

#pragma mark - 点击按钮事件响应
- (void)clickBtn:(ZLButton *)btn{
    
    if ([btn tag]==2) {}else{
        self.selectBtn.selected = NO;
        self.selectBtn = btn;
        self.selectBtn.selected = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(clickButtonWithIndex:)]) {
        [self.delegate clickButtonWithIndex:btn.tag];
    }
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 0; // 动画持续时间
    animation.repeatCount = 1; // 重复次数
    animation.timingFunction = 0;
    //    animation.autoreverses = YES; // 动画结束时执行逆动画
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:0.6]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:1.0]; // 结束时的倍率
    
    // 添加动画
    [btn.layer addAnimation:animation forKey:@"scale-layer"];
    
}

- (void)layoutSubviews{
    
    for (NSInteger i = 0 ; i < 5; i++) {
        ZLButton *btn = self.subviews[i];
        if (i==2) {
            btn.frame = CGRectMake(i * TABBAR_BUTTON_WIDTH, 1, TABBAR_BUTTON_WIDTH, TABBAR_HEIGHT);
        }else{
            btn.frame = CGRectMake(i * TABBAR_BUTTON_WIDTH, -7, TABBAR_BUTTON_WIDTH, TABBAR_HEIGHT);
        }
    }
}

@end
