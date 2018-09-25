//
//  ZLPublishCapsuleViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/21.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLPublishCapsuleViewController.h"
#import "PlaceholderTextView.h"
#import "ZLCapsuleModel.h"
#import "CustomAlbum.h"

@interface ZLPublishCapsuleViewController () <customDelegate, UITextViewDelegate>
{
    UIButton *publishButton;
    
    FMDBManager *manager;
    NSData *imgData;
    float width;
    float height;
}

@property (nonatomic, strong) ZLCapsuleModel *capsuleModel;
@property (nonatomic, strong) CustomAlbum    *customAlbum;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *publishImg;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation ZLPublishCapsuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kUIColorFromRGB(WHITE);
    
    [super setNavigationTitle:@"发布胶囊"];
    
    // 选择图片入口添加事件
    UITapGestureRecognizer *selectTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImg:)];
    [_publishImg addGestureRecognizer:selectTap];

    [self _initPublishButton];
}

#pragma mark - 代码方式发布入口
- (void)_initPublishButton
{
    _textView.placeholder = @"写你所想...";
    _textView.delegate = self;
    _textView.placeholderFont = FONT_PING_REGULAR(12.0f);
    
    publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.frame = CGRectMake(0, 25, 40, 40);
    [publishButton setImage:[UIImage imageNamed:@"publish_note"] forState:UIControlStateNormal];
    publishButton.showsTouchWhenHighlighted = YES;
    [publishButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barright = [[UIBarButtonItem alloc] initWithCustomView:publishButton];
    self.navigationItem.rightBarButtonItem = barright;
}

#pragma mark - 选择图片入口进入涂图视图控制器
- (void)selectImg:(UITapGestureRecognizer *)sender {
    if (self.customAlbum == nil) {
        self.customAlbum = [CustomAlbum simple];
        self.customAlbum.showDelegate = self;
        self.customAlbum.album = @"chatMessage";
    }
    [self.customAlbum showSimpleWithController:self];
}

#pragma mark - 发布事件
- (void)sendAction:(UIButton *)sender
{
    if (_textView.text == nil || [_textView.text isEqualToString:@""]) {
        [CommonUtil NotiTip:@"胶囊内容不能为空" color:TIP_COLOR];
    } else {
        manager = [FMDBManager shareManager];
        [manager createCapsule];
        [self insertDataFMDB];
    }
}

#pragma mark - 发布便签插入数据库
- (void)insertDataFMDB {
    NSDate *sendDate = [NSDate date];
    NSString *ctime = [NSString stringWithFormat:@"%ld", (long)[sendDate timeIntervalSince1970]];
    
    _capsuleModel = [[ZLCapsuleModel alloc] init];
    _capsuleModel.uid = [ctime intValue];
    _capsuleModel.title = @"";
    _capsuleModel.width = width;
    _capsuleModel.height = height;
    _capsuleModel.content = _textView.text;
    _capsuleModel.statusTag = _statusTag;
    if (_futureTime==nil || [_futureTime isEqualToString:@""]) {
        _capsuleModel.cdate = [CommonUtil getLocalTime];
        _capsuleModel.today = 0;
    } else {
        _capsuleModel.cdate = _futureTime;
        _capsuleModel.today = 1;
    }
    
    _capsuleModel.ctime = ctime;
    _capsuleModel.imgData = imgData;
    [manager insertCapsuleDataWithModel:_capsuleModel];
    
    [CommonUtil NotiTip:@"胶囊发布成功" color:SUCCESS_COLOR];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [CommonUtil registerNotice:@"capsule_success" object:nil];
}

#pragma mark - 显示图片
- (void)showImage:(UIImage *)showImg {
    width = showImg.size.width;
    height = showImg.size.height;
    
    _publishImg.image = showImg;
    imgData = UIImageJPEGRepresentation(showImg, 1);
}

#pragma mark - UITextView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger res = 600 - [new length];
    
    _numLabel.text = [NSString stringWithFormat:@"%d字", (int)res];
    if (res >= 0) {
        return YES;
    } else {
        if (res<0) {
            _numLabel.text = [NSString stringWithFormat:@"0字"];
            _textView.text = [new substringToIndex:600];
            return NO;
        }
        return NO;
    }
    
}

@end
