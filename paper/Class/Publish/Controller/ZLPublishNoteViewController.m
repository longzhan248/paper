//
//  ZLPublishNoteViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLPublishNoteViewController.h"

@interface ZLPublishNoteViewController () <customDelegate>

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
}

#pragma mark - 代码方式实现返回和发布入口
- (void)_initBackAndPublishButton
{
    self.view.shiftHeightAsDodgeViewForMLInputDodger = NAVIGATIONHEIGHT;
    [self.view registerAsDodgeViewForMLInputDodger];
    
    _textView.placeholder = @"写你所想...";
    _textView.placeholderFont = FONT_PING_REGULAR(12.0f);
    
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0, 20, 53, 53);
    closeButton.imageEdgeInsets = UIEdgeInsetsMake(5, -25, 0, 0);
    [closeButton setImage:[UIImage imageNamed:@"wclose"] forState:UIControlStateNormal];
    closeButton.showsTouchWhenHighlighted = YES;
    [closeButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleft = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItem = barleft;
    
    publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.frame = CGRectMake(0, 25, 45, 40);
    publishButton.titleLabel.font = FONT_PING_REGULAR(14.0f);
    [publishButton setTitle:@"发布" forState:UIControlStateNormal];
    [publishButton setTitleColor:kUIColorFromRGB(BLACK) forState:UIControlStateNormal];
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
    [self insertDataFMDB];
}

#pragma mark - 发布便签插入数据库
- (void)insertDataFMDB {
    
    FMDBManager *manager = [[FMDBManager alloc] init];
    [FMDBManager shareManager];
    
    NSDate *sendDate = [NSDate date];
    NSString *ctime = [NSString stringWithFormat:@"%ld", (long)[sendDate timeIntervalSince1970]];
    // 在数据库里插入数据
    _noteModel = [[ZLNoteModel alloc] init];
    _noteModel.uid = [ctime intValue];
    _noteModel.title = @"";
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

#pragma mark - 显示图片
- (void)showImage:(UIImage *)showImg
{
    _selectImgView.image = showImg;
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
    colorTag = (int)sender.tag;
}

@end
