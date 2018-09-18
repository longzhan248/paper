//
//  ZLNoteDetailViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/18.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLNoteDetailViewController.h"
#import "ZLNoteModel.h"

@interface ZLNoteDetailViewController ()
{
    UIScrollView *scrollView;
    UILabel *contentLabel;
    UIImageView *imgView;
}

@end

@implementation ZLNoteDetailViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    [super setNavigationTitle:@"便签详情"];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scrollView.backgroundColor = kUIColorFromRGB(WHITE);
    [self.view addSubview:scrollView];
    
    [self _initContentView];
}

#pragma mark - 初始化内容详情
- (void)_initContentView
{
    // 获取便签内容的高度
    NSString *content = _noteModel.content;
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    CGFloat height = [[content LabelContent:content] heightWithLabelWidth:ScreenWidth-LEFT_PADDING_HEIGHT*2].height;
    
    //便签内容Label
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_PADDING_HEIGHT, 20, ScreenWidth-LEFT_PADDING_HEIGHT*2, height)];
    contentLabel.font = FONT_PING_REGULAR(16.0f);
    contentLabel.textColor = kUIColorFromRGB(BLACK);
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contentLabel.numberOfLines = 0;
    contentLabel.attributedText = [content LabelContent:content];
    [scrollView addSubview:contentLabel];
    
    //便签图片，换一种布局方式和图片contentMode来显示
    UIImage *image = [UIImage imageWithData:_noteModel.imgData];
    imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [scrollView addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        //顶部
        make.top.mas_equalTo(contentLabel.bottom+LEFT_PADDING_HEIGHT);
        //左侧
        make.left.equalTo(self.view.mas_left).with.offset(LEFT_PADDING_HEIGHT);
        //右侧
        make.right.equalTo(self.view.mas_right).with.offset(-LEFT_PADDING_HEIGHT);
        //高度
        make.height.mas_equalTo(NOTEHEADER_HEIGHT);
    }];
    
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    imgView.image = image;
    
    scrollView.contentSize = CGSizeMake(ScreenWidth, height+NOTEHEADER_HEIGHT);
}


@end
