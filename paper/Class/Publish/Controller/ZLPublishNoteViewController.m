//
//  ZLPublishNoteViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLPublishNoteViewController.h"
#import "PlaceholderTextView.h"
#import "MLInputDodger.h"
#import "CustomAlbum.h"
#import "ZLNoteModel.h"
#import <RadioButton/RadioButton.h>

@interface ZLPublishNoteViewController () <customDelegate, UITextViewDelegate>
{
    UIView *topView;
    UIButton *closeButton;
    UILabel *titleLabel;
    
    UIButton *publishButton;
    
    NSData *imgData;
    
    int colorTag;
    
    BOOL isSelectTag;
    
    float width;
    float height;
    
    FMDBManager *manager;
}

@property (nonatomic, strong) CustomAlbum *customAlbum;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImgView;

@end

@implementation ZLPublishNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setNavigationTitle:@"发布便签"];
    
    [self _initBackAndPublishButton];
    
    //选择图片入口添加事件
    UITapGestureRecognizer *selectTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImg:)];
    [_selectImgView addGestureRecognizer:selectTap];
    if (_noteModel != nil) {
        _textView.placeholder = @"";
        _textView.text = _noteModel.content;
        if ([_noteModel.imgData isEqual:@""] || _noteModel.imgData == nil) {
            
        } else {
            _selectImgView.image = [UIImage imageWithData:_noteModel.imgData];
        }
        RadioButton *radioButton = [self.view viewWithTag:10+_noteModel.colorTag];
        radioButton.selected = YES;
    }
}

#pragma mark - 代码方式实现返回和发布入口
- (void)_initBackAndPublishButton
{
    self.view.shiftHeightAsDodgeViewForMLInputDodger = NAVIGATIONHEIGHT;
    [self.view registerAsDodgeViewForMLInputDodger];
    
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

#pragma mark - 选择图片入口进入涂图视图控制器
- (void)selectImg:(UITapGestureRecognizer *)sender
{
    if (self.customAlbum == nil)
    {
        self.customAlbum = [CustomAlbum simple];
        self.customAlbum.showDelegate = self;
        self.customAlbum.album = @"chatMessage";
    }
    [self.customAlbum showSimpleWithController:self];
}

#pragma mark - 发布事件
- (void)sendAction:(UIButton *)sender
{
    manager = [[FMDBManager alloc] init];
    [FMDBManager shareManager];
    if (_noteModel != nil) {
        [self updateDataFMDB];
    } else {
        [self insertDataFMDB];
    }
}

#pragma mark - 发布便签插入数据库
- (void)insertDataFMDB {
    
    NSDate *sendDate = [NSDate date];
    NSString *ctime = [NSString stringWithFormat:@"%ld", (long)[sendDate timeIntervalSince1970]];
    
    // 在数据库里插入数据
    _noteModel = [[ZLNoteModel alloc] init];
    _noteModel.uid = [ctime intValue];
    _noteModel.title = @"";
    _noteModel.width = width;
    _noteModel.height = height;
    _noteModel.content = _textView.text;
    _noteModel.starTag = 0;
    _noteModel.colorTag = colorTag;
    _noteModel.ctime = ctime;
    _noteModel.imgData = imgData;
    [manager insterDataWithModel:_noteModel];
    
    [CommonUtil NotiTip:@"便签发布成功" color:SUCCESS_COLOR];
    [self dismissViewControllerAnimated:YES completion:nil];
    [CommonUtil registerNotice:@"publish_success" object:nil];
}

#pragma mark - 修改便签更新数据库
- (void)updateDataFMDB {
    
    NSDate *sendDate = [NSDate date];
    NSString *ctime = [NSString stringWithFormat:@"%ld", (long)[sendDate timeIntervalSince1970]];
    
    if (width == 0) {
        width = _noteModel.width;
    }
    if (height==0) {
        height = _noteModel.height;
    }
    if (!isSelectTag) {
        colorTag = _noteModel.colorTag;
    }
    if ([imgData isEqual:@""] || imgData == nil) {
        imgData = _noteModel.imgData;
    }
    _noteModel.width = width;
    _noteModel.height = height;
    _noteModel.content = _textView.text;
    _noteModel.starTag = 0;
    _noteModel.colorTag = colorTag;
    _noteModel.ctime = ctime;
    _noteModel.imgData = imgData;
    
    // 先删除再插入
    [manager deleteFind:_noteModel.uid];
    [manager insterDataWithModel:_noteModel];
    
    [CommonUtil NotiTip:@"便签修改成功" color:SUCCESS_COLOR];
    [self dismissViewControllerAnimated:YES completion:nil];
    [CommonUtil registerNotice:@"publish_success" object:nil];
}

#pragma mark - 显示图片
- (void)showImage:(UIImage *)showImg
{
    width = showImg.size.width;
    height = showImg.size.height;
    
    _selectImgView.image = showImg;
    imgData = UIImageJPEGRepresentation(showImg, 1);
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

#pragma mark - 选择标签颜色  0.green 1.red 2.yellow 3.purple
- (IBAction)tagAction:(RadioButton *)sender {
    isSelectTag = YES;
    colorTag = (int)sender.tag-10;
}

@end
