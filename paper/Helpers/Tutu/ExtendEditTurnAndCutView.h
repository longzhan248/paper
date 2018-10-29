//
//  ExtendEditTurnAndCutView.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <TuSDKGeeV1/TuSDKGeeV1.h>

@protocol EditTurnDelegate <NSObject>

- (void)editTurnAndCutView:(UIImageView *)img;

@end

@interface ExtendEditTurnAndCutView : TuSDKPFEditTurnAndCutView
/**
 *  向右旋转按钮
 */
@property (nonatomic, readonly) UIButton *trunRightButton;
@property (nonatomic,retain) id<EditTurnDelegate> cutDelegate;
@end
