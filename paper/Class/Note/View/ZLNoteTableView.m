//
//  ZLNoteTableView.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "ZLNoteTableView.h"
#import "ZLNoteDetailViewController.h"
#import "ZLPublishNoteViewController.h"

@implementation ZLNoteTableView

#pragma mark tableView datasource
//子类可以覆盖父类中得这些方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _noteCell = [ZLNoteCell cellWithTableView:tableView];
    _noteCell.noteModel = self.data[indexPath.row];
    return _noteCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZLNoteModel *noteModel = [self.data objectAtIndex:indexPath.row];
    ZLNoteDetailViewController *noteDetail = [[ZLNoteDetailViewController alloc] init];
    noteDetail.noteModel = noteModel;
    [self.zl_viewController.navigationController pushViewController:noteDetail animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZLNoteModel *noteModel = [self.data objectAtIndex:indexPath.row];
    UITableViewRowAction *deleteRowAction;
    UITableViewRowAction *moreRowAction;
    deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        FMDBManager *manager = [[FMDBManager alloc]init];
        [FMDBManager shareManager];
        [manager deleteFind:noteModel.uid];
        
        [self.data removeObjectAtIndex:indexPath.row];
        [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.deleteDelegate updateDelete];
        
    }];
    deleteRowAction.backgroundColor = kUIColorFromRGB(0xe53a38);
    
    moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        ZLPublishNoteViewController *noteCtrl = [[ZLPublishNoteViewController alloc] init];
        noteCtrl.noteModel = noteModel;
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:noteCtrl];
        [self.zl_viewController presentViewController:baseNav animated:YES completion:nil];
    }];
    moreRowAction.backgroundColor = kUIColorFromRGB(0x61cefe);
    return @[deleteRowAction,moreRowAction];
}

@end
