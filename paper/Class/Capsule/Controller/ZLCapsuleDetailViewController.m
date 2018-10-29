//
//  ZLCapsuleDetailViewController.m
//  paper
//
//  Created by 詹龙 on 2018/9/26.
//  Copyright © 2018 longzhan. All rights reserved.
//

#import "ZLCapsuleDetailViewController.h"
#import "ZLCapsuleModel.h"
#import "FlashShineLabel.h"
#import "ZLPublishCapsuleViewController.h"

@interface ZLCapsuleDetailViewController ()
{
    UIImageView *imgView;
    
    NSTimer *timer;
    
    UIButton *leftButton;
    UIButton *rightButton;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *textArray;
@property (strong, nonatomic) FlashShineLabel *shineLabel;
- (IBAction)closeAction:(id)sender;
- (IBAction)editAction:(UIButton *)sender;

@end

@implementation ZLCapsuleDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [NSNOTIFICATION addObserver:self selector:@selector(successAction:) name:@"capsule_success" object:nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kUIColorFromRGB(0x00B7EE);
    
    self.shineLabel = ({
        FlashShineLabel *label = [[FlashShineLabel alloc] initWithFrame:CGRectMake(LEFT_PADDING_HEIGHT, NOTEBGCELL_HEIGHT, ScreenWidth-LEFT_PADDING_HEIGHT*2, CGRectGetHeight(self.view.bounds)-LEFT_PADDING_HEIGHT)];
        label.numberOfLines = 0;
        label.text = _capsuleModel.content;
        label.font = FONT_PING_REGULAR(16.0f);
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        label;
    });
    [self.scrollView addSubview:self.shineLabel];

    // 便签图片
    UIImage *image = [UIImage imageWithData:_capsuleModel.imgData];
    imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.scrollView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shineLabel.bottom+LEFT_PADDING_HEIGHT);
        make.left.equalTo(self.view.mas_left).with.offset(LEFT_PADDING_HEIGHT);
        make.right.equalTo(self.view.mas_right).with.offset(-LEFT_PADDING_HEIGHT);
        make.height.mas_equalTo(NOTEHEADER_HEIGHT);
    }];
    
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.clipsToBounds = YES;
    imgView.alpha = 0;
    imgView.image = image;
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.shineLabel.height+NOTEHEADER_HEIGHT*2);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.shineLabel shine];
    [UIView animateWithDuration:1.0 animations:^{
        imgView.alpha = 1;
    }];
}

#pragma mark - 更新数据后调用
- (void)successAction:(NSNotification *)notification
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editAction:(UIButton *)sender {
    ZLPublishCapsuleViewController *capsuleCtrl = [[ZLPublishCapsuleViewController alloc] init];
    capsuleCtrl.skip = @"present";
    capsuleCtrl.capsuleModel = _capsuleModel;
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:capsuleCtrl];
    [self presentViewController:baseNav animated:YES completion:nil];
}


@end
