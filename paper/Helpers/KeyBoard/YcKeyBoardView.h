//
//  YcKeyBoardView.h
//  KeyBoardAndTextView
//
//  Created by zzy on 14-5-28.
//  Copyright (c) 2014年 zzy. All rights reserved.
//
#define kStartLocation 20
#import <UIKit/UIKit.h>
#import "CustomTextView.h"

@class YcKeyBoardView;
@protocol YcKeyBoardViewDelegate <NSObject>

-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView;
@end

@interface YcKeyBoardView : UIView<UITextViewDelegate>

@property (nonatomic,retain)UIView *bgView;
-(void)initTextView:(NSString *)tipPlaceholder;

@property (nonatomic,retain)UILabel *topLabel;
@property (nonatomic,retain)UILabel *labelPlaceholder;

- (id)initWithFrame:(CGRect)frame tipString:(NSString *)tipString;

@property (nonatomic,strong) CustomTextView *textView;
@property (nonatomic,assign) id<YcKeyBoardViewDelegate> delegate;
@end
