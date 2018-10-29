//
//  ZLTargetDetailViewController.m
//  paper
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLTargetDetailViewController.h"
#import "ZLTargetModel.h"
#import "LCActionSheet.h"
#import "ZLPublishTargetViewController.h"

@interface ZLTargetDetailViewController () <LCActionSheetDelegate, UpdateDelegate>
{
    UIButton *editButton;
    
    LCActionSheet *actionSheet;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentConstraint;

@end

@implementation ZLTargetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [super setNavigationTitle:@"目标详情"];
    
    [self _initEditView];
    [self assignmentView];
}

#pragma mark - 编辑视图
- (void)_initEditView {
    editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 25, 30, 30);
    [editButton setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
    editButton.showsTouchWhenHighlighted = YES;
    [editButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barright = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = barright;
}

#pragma mark - 目标任务赋值
- (void)assignmentView {
    _titleLabel.text = _targetModel.title;
    NSString *content = _targetModel.content;
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    CGFloat height = [[content zl_LabelContent:content] zl_heightWithLabelWidth:ScreenWidth-LEFT_TARGET_HEIGHT*2].height;
    _contentConstraint.constant = height;
    _contentLabel.attributedText = [content zl_LabelContent:content];
    
    _dateLabel.text = _targetModel.endDate;
}

#pragma mark - 编辑事件的action
- (void)editAction:(UIButton *)sender {
    actionSheet = [[LCActionSheet alloc] initWithTitle:@"闪念胶囊"
                                          buttonTitles:@[@"修改",@"删除"]
                                        redButtonIndex:0
                                              delegate:self];
    [actionSheet show];
}

#pragma mark - LCActionSheetDelegate
- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        ZLPublishTargetViewController *targetCtrl = [[ZLPublishTargetViewController alloc] init];
        targetCtrl.delegate = self;
        targetCtrl.targetModel = _targetModel;
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:targetCtrl];
        [self presentViewController:baseNav animated:YES completion:nil];
    } else if (buttonIndex == 1) {
        FMDBManager *manager = [FMDBManager shareManager];
        [manager createTarget];
        [manager deleteFind:@"target" uid:_targetModel.uid];
        [CommonUtil registerNotice:@"target_success" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UpdateDelegate
- (void)updateTarget:(ZLTargetModel *)targetModel {
    _targetModel = targetModel;
    [self assignmentView];
}

@end
