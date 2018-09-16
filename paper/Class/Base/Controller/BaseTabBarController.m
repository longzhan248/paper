//
//  BaseTabBarController.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //隐藏TabBar
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    
    if (!model) {
        model = [PopMenuModel
                 allocPopMenuModelWithImageNameString:PUBLISH_NOTE_IMG
                 AtTitleString:ZLLangaueStr(@"TBNote")
                 AtTextColor:[UIColor whiteColor]
                 AtTransitionType:PopMenuTransitionTypeSystemApi
                 AtTransitionRenderingColor:nil];
    }
    
    if (!model2) {
        model2 = [PopMenuModel
                  allocPopMenuModelWithImageNameString:PUBLISH_CAPSULE_IMG
                  AtTitleString:ZLLangaueStr(@"TBCapsule")
                  AtTextColor:[UIColor whiteColor]
                  AtTransitionType:PopMenuTransitionTypeSystemApi
                  AtTransitionRenderingColor:nil];
    }
    
    if (!model3) {
        model3 = [PopMenuModel
                  allocPopMenuModelWithImageNameString:PUBLISH_TARGET_IMG
                  AtTitleString:ZLLangaueStr(@"TBTarget")
                  AtTextColor:[UIColor whiteColor]
                  AtTransitionType:PopMenuTransitionTypeSystemApi
                  AtTransitionRenderingColor:nil];
    }
    
    _menu.dataSource = @[model, model2, model3];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabBar];
    
    _menu = [HyPopMenuView sharedPopMenuManager];
    _menu.delegate = self;
    _menu.popMenuSpeed = 12.0f;
    _menu.automaticIdentificationColor = false;
    _menu.animationType = HyPopMenuViewAnimationTypeViscous;
}

#pragma mark - 自定义tabbar的View
- (void)initTabBar{
    
    self.zlTabBar = [ZLTabBar buttonView];
    self.zlTabBar.frame = CGRectMake(0, ScreenHeight-TABBAR_HEIGHT,ScreenWidth, TABBAR_HEIGHT);
    self.zlTabBar.backgroundColor = [UIColor whiteColor];
    self.zlTabBar.delegate = self;
    self.zlTabBar.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor;
    self.zlTabBar.layer.shadowOffset = CGSizeMake(10,10);
    self.zlTabBar.layer.shadowOpacity = 0.65;
    self.zlTabBar.layer.shadowRadius = 8;
    [self.view addSubview:self.zlTabBar];
    
    NSArray *titleArray = @[ZLLangaueStr(@"TBNote"),ZLLangaueStr(@"TBCapsule"),@"",ZLLangaueStr(@"TBTarget"),ZLLangaueStr(@"TBSetting")];
    
    for (NSInteger index = 0; index <titleArray.count; index++) {
        titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(index * TABBAR_BUTTON_WIDTH, 30, TABBAR_BUTTON_WIDTH, 20);
        titleButton.userInteractionEnabled = NO;
        titleButton.titleLabel.font = FONT_PING_REGULAR(10);
        [titleButton setTitle:titleArray[index] forState:UIControlStateNormal];
        titleButton.tag = 10+index;
        if (index==0) {
            lastButton = titleButton;
            lastButton.selected = YES;
        }
        [titleButton setTitleColor:kUIColorFromRGB(SECOND_COLOR) forState:UIControlStateNormal];
        [titleButton setTitleColor:kUIColorFromRGB(MAIN_COLOR) forState:UIControlStateSelected];
        [self.zlTabBar addSubview:titleButton];
    }
}

#pragma mark -button代理
- (void)clickButtonWithIndex:(NSInteger)index{
    
    if (index==2) {
        _menu.backgroundType = HyPopMenuViewBackgroundTypeDarkTranslucent;
        [_menu openMenu];
        return;
    }
    lastButton.selected = NO;
    lastButton = (UIButton *)[self.view viewWithTag:10+index];
    lastButton.selected = YES;
    
    self.selectedIndex = index;
}

#pragma mark - 是否显示TabBar
- (void)showTabbar:(BOOL)show
{
    [UIView animateWithDuration:0.30 animations:^{
        if (show) {
            self.zlTabBar.bottom = ScreenHeight;
        }else{
            self.zlTabBar.bottom = ScreenHeight+TABBAR_HEIGHT;
        }
    }];
    
}

#pragma mark - ui 私有的方法-初始化子控制器
- (void)_resizeView:(BOOL)showTarbar
{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (showTarbar) {
                subView.height = ScreenHeight;
            }else{
                subView.height = ScreenHeight+TABBAR_HEIGHT;
            }
        }
    }
}

@end
