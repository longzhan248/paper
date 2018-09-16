//
//  CustomAlbum.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "TutuSimpleBase.h"
#import "CustomAlbumViewController.h"
#import "CustomAlbumView.h"
#import "CustomGridView.h"
#import "CustomPopView.h"
#import "CustomPopList.h"
#import "CustomPhotoViewController.h"
#import "CustomPhoto.h"
#import "CustomEditViewController.h"

@protocol customDelegate <NSObject>

- (void)showImage:(UIImage *)showImg;
@end

@interface CustomAlbum : TutuSimpleBase

@property (nonatomic, copy) NSString *album;
@property (nonatomic, assign) id <customDelegate> showDelegate;

@end
