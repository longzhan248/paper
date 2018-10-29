//
//  ZLMainTabBarController.h
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

@interface ZLMainTabBarController : BaseTabBarController <UINavigationControllerDelegate>
{
    NSMutableArray *viewControllers;
}
@end
