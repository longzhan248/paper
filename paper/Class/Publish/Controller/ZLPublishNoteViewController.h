//
//  ZLPublishNoteViewController.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "BaseViewController.h"
#import "PlaceholderTextView.h"
#import "MLInputDodger.h"
#import "CustomAlbum.h"
#import "ZLNoteModel.h"
#import <RadioButton/RadioButton.h>


@interface ZLPublishNoteViewController : BaseViewController
{
    UIView *topView;
    UIButton *closeButton;
    UILabel *titleLabel;
    
    UIButton *publishButton;
    
    NSData *imgData;
    
    int colorTag;
}

@property (nonatomic, strong) ZLNoteModel *noteModel;
@property (nonatomic, strong) CustomAlbum *customAlbum;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImgView;

- (IBAction)tagAction:(RadioButton *)sender;


@end
