//
//  BaseTableView.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *data;


@end
