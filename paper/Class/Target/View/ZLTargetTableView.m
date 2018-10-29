//
//  ZLTargetTableView.m
//  paper
//
//  Created by 詹龙 on 2018/9/29.
//  Copyright © 2018 longzhan. All rights reserved.
//

#import "ZLTargetTableView.h"
#import "ZLTargetModel.h"
#import "ZLTargetCell.h"
#import "ZLTargetDetailViewController.h"

@interface ZLTargetTableView ()

@property (nonatomic, strong) ZLTargetCell *targetCell;
@property (nonatomic, strong) ZLTargetModel *targetModel;

@end

@implementation ZLTargetTableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _targetCell = [ZLTargetCell cellWithTableView:tableView];
    _targetCell.targetModel = self.data[indexPath.row];
    return _targetCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 255.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _targetModel = self.data[indexPath.row];
    ZLTargetDetailViewController *targetCtrl = [[ZLTargetDetailViewController alloc] init];
    targetCtrl.targetModel = _targetModel;
    [self.zl_viewController.navigationController pushViewController:targetCtrl animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
