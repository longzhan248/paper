//
//  ExtendEditTurnAndCutView.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ExtendEditTurnAndCutView.h"

/**
 *  自定义旋转和裁剪视图
 */
@implementation ExtendEditTurnAndCutView

/**
 *  每个视图都会执行initView，自定义视图在这里开始
 */
-(void)lsqInitView
{
    [super lsqInitView];
    
    // 修改底部工具栏背景
    //    self.bottomBar.backgroundColor = lsqRGB(255,123,44);
    // 改变底部镜像按钮为向右旋转按钮
    // 隐藏镜像按钮
    //    self.bottomBar.mirrorButton.hidden = YES;
    // 创建向右旋转按钮
    //    _trunRightButton = [UIButton buttonWithFrame:self.bottomBar.mirrorButton.frame
    //                             imageLSQBundleNamed:@"style_default_edit_button_trun_right"];
    //    // 绑定动作
    //    [_trunRightButton addTouchUpInsideTarget:self action:@selector(onImageTurnRightAction)];
    // 添加到视图
    self.bottomBar.completeButton.titleLabel.font = FONT_PING_REGULAR(14.0f);
    [self.bottomBar.completeButton setBackgroundImageColor:kUIColorFromRGB(MAIN_COLOR) forState:UIControlStateNormal];
    //    [self.bottomBar.completeButton setBackgroundColor:kUIColorFromRGB(MAIN_COLOR)];
}

/**
 *  处理图片
 */
- (void)ImageCompleteAction:(UIButton *)sender
{
    //    [CommonUtil registerNotice:@"cure_img" object:nil];
    //    [self.cutDelegate editTurnAndCutView:self.editImageView.imageView];
    [self.zl_viewController.navigationController dismissModalViewControllerAnimated];
    //    [self.editImageView changeImage:lsqImageChangeTurnRight];
}
@end
