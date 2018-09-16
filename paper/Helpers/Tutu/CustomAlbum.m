//
//  CustomAlbum.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "CustomAlbum.h"
#import "ExtendEditTurnAndCutView.h"

@interface CustomAlbum()<TuSDKPFEditTurnAndCutDelegate>
{
    // 自定义系统相册组件
    TuSDKCPAlbumComponent *_albumComponent;
}
@end

@implementation CustomAlbum

- (instancetype)init;
{
    self = [super initWithGroupId:2 title:NSLocalizedString(@"simple_EditAdvancedComponent", @"高级图片编辑组件")];
    return self;
}

- (void)showSimpleWithController:(UIViewController *)controller
{
    if (!controller) return;
    self.controller = controller;
    
    _albumComponent =
    [TuSDKGeeV1 albumCommponentWithController:controller
                                callbackBlock:^(TuSDKResult *result, NSError *error, UIViewController *controller)
     {
         // 获取头像图片
         if (error) {
             lsqLError(@"album reader error: %@", error.userInfo);
             return;
         }
         [self openEditAndCutWithController:controller result:result];
     }];
    _albumComponent.options.albumOptions.componentClazz = [CustomAlbumViewController class];
//        _albumComponent.options.albumOptions.disableAutoSkipToPhotoList = YES;
//        _albumComponent.options.albumOptions.viewClazz = [CustomAlbumView class];
    _albumComponent.options.photosOptions.componentClazz = [CustomPhotoViewController class];
//        _albumComponent.options.photosOptions.viewClazz = [CustomPhoto class];
//        _albumComponent.options.albumOptions.cellViewClazz = [CustomPopList class];
    [_albumComponent showComponent];
}

/**
 *  开启图片编辑组件 (裁剪)
 *
 *  @param controller 来源控制器
 *  @param result     处理结果
 */
- (void)openEditAndCutWithController:(UIViewController *)controller
                              result:(TuSDKResult *)result;
{
    if (!controller || !result) return;
    
    TuSDKPFEditTurnAndCutOptions *opt = [TuSDKPFEditTurnAndCutOptions build];
    
    opt.viewClazz = [ExtendEditTurnAndCutView class];
    // 是否开启滤镜支持 (默认: 关闭)
    opt.enableFilters = YES;
    // 开启滤镜历史记录
    opt.enableFilterHistory = YES;
    // 开启在线滤镜
    opt.enableOnlineFilter = YES;
    // 显示滤镜标题视图
    opt.displayFilterSubtitles = YES;
    //    opt.editImageViewClazz = [TouchImgView class];
    // 需要裁剪的长宽
    if ([self.album isEqualToString:@"editMusic"]) {
        opt.cutSize = CGSizeMake(640, 340);
    }else if ([self.album isEqualToString:@"chatMessage"]){}else{
        opt.cutSize = CGSizeMake(640, 640);
    }
    
    // 是否显示处理结果预览图 (默认：关闭，调试时可以开启)
    opt.showResultPreview = NO;
    
    // 保存到系统相册的相册名称
    opt.componentClazz = [CustomEditViewController class];
    opt.outputCompress = 1.0f;
    TuSDKPFEditTurnAndCutViewController *tcController = opt.viewController;
    // 添加委托
    tcController.delegate = self;
    // 处理图片对象 (处理优先级: inputImage > inputTempFilePath > inputAsset)
    tcController.inputImage = result.image;
    tcController.inputTempFilePath = result.imagePath;
    tcController.inputAsset = result.imageAsset;
    [controller.navigationController pushViewController:tcController animated:YES];
}

/**
 *  图片编辑完成
 *
 *  @param controller 旋转和裁剪视图控制器
 *  @param result 旋转和裁剪视图控制器处理结果
 */
- (void)onTuSDKPFEditTurnAndCut:(TuSDKPFEditTurnAndCutViewController *)controller result:(TuSDKResult *)result;
{
    _albumComponent = nil;
    
    // 清除所有控件
    [controller dismissModalViewControllerAnimated];
    UIImage *resultImg = result.loadResultImage;
    [self.showDelegate showImage:resultImg];
    lsqLDebug(@"onTuSDKPFEditTurnAndCut: %@", result);
}

/**
 *  获取组件返回错误信息
 *
 *  @param controller 控制器
 *  @param result     返回结果
 *  @param error      异常信息
 */
- (void)onComponent:(TuSDKCPViewController *)controller result:(TuSDKResult *)result error:(NSError *)error;
{
    lsqLDebug(@"onComponent: controller - %@, result - %@, error - %@", controller, result, error);
}

@end
