//
//  UIScrollView+ZLHeaderScaleImage.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "UIScrollView+ZLHeaderScaleImage.h"

#import <objc/runtime.h>

#define ZLKeyPath(objc,keyPath) @(((void)objc.keyPath,#keyPath))

@interface NSObject (ZLMethodSwizzling)

/**
 *  交换对象方法
 *
 *  @param origSelector    原有方法
 *  @param swizzleSelector 现有方法(自己实现方法)
 */
+ (void)zl_swizzleInstanceSelector:(SEL)origSelector
                   swizzleSelector:(SEL)swizzleSelector;

/**
 *  交换类方法
 *
 *  @param origSelector    原有方法
 *  @param swizzleSelector 现有方法(自己实现方法)
 */
+ (void)zl_swizzleClassSelector:(SEL)origSelector
                swizzleSelector:(SEL)swizzleSelector;

@end

@implementation NSObject (ZLMethodSwizzling)

+ (void)zl_swizzleInstanceSelector:(SEL)origSelector
                   swizzleSelector:(SEL)swizzleSelector {
    
    // 获取原有方法
    Method origMethod = class_getInstanceMethod(self,
                                                origSelector);
    // 获取交换方法
    Method swizzleMethod = class_getInstanceMethod(self,
                                                   swizzleSelector);
    
    // 注意：不能直接交换方法实现，需要判断原有方法是否存在,存在才能交换
    // 如何判断？添加原有方法，如果成功，表示原有方法不存在，失败，表示原有方法存在
    // 原有方法可能没有实现，所以这里添加方法实现，用自己方法实现
    // 这样做的好处：方法不存在，直接把自己方法的实现作为原有方法的实现，调用原有方法，就会来到当前方法的实现
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (!isAdd) { // 添加方法失败，表示原有方法存在，直接替换
        method_exchangeImplementations(origMethod, swizzleMethod);
    }else {
        class_replaceMethod(self, swizzleSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
}

+ (void)zl_swizzleClassSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector
{
    // 获取原有方法
    Method origMethod = class_getClassMethod(self,
                                             origSelector);
    // 获取交换方法
    Method swizzleMethod = class_getClassMethod(self,
                                                swizzleSelector);
    
    // 添加原有方法实现为当前方法实现
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (!isAdd) { // 添加方法失败，原有方法存在，直接替换
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
}

@end

// 默认图片高度
CGFloat oriImageH = 350;

@implementation UIScrollView (ZLHeaderScaleImage)

+ (void)load
{
    [self zl_swizzleInstanceSelector:@selector(setTableHeaderView:) swizzleSelector:@selector(setZl_TableHeaderView:)];
}

// 拦截通过代码设置tableView头部视图
- (void)setZl_TableHeaderView:(UIView *)tableHeaderView
{
    
    // 不是UITableView,就不需要做下面的事情
    if (![self isMemberOfClass:[UITableView class]]) return;
    
    // 设置tableView头部视图
    [self setZl_TableHeaderView:tableHeaderView];
    
    // 设置头部视图的位置
    UITableView *tableView = (UITableView *)self;
    
    self.zl_headerScaleImageHeight = tableView.tableHeaderView.frame.size.height;
    
}

// 懒加载头部imageView
- (UIImageView *)zl_headerImageView
{
    UIImageView *imageView = objc_getAssociatedObject(self, _cmd);
    if (imageView == nil) {
        
        imageView = [[UIImageView alloc] init];
        
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self insertSubview:imageView atIndex:0];
        
        // 保存imageView
        objc_setAssociatedObject(self, _cmd, imageView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return imageView;
}

// 属性：zl_isInitial
- (BOOL)zl_isInitial
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setZl_isInitial:(BOOL)zl_isInitial
{
    objc_setAssociatedObject(self, @selector(zl_isInitial), @(zl_isInitial),OBJC_ASSOCIATION_ASSIGN);
}

// 属性： zzl_headerImageViewHeight
- (void)setZl_headerScaleImageHeight:(CGFloat)zl_headerScaleImageHeight
{
    objc_setAssociatedObject(self, @selector(zl_headerScaleImageHeight), @(zl_headerScaleImageHeight),OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    // 设置头部视图的位置
    [self setupHeaderImageViewFrame];
}
- (CGFloat)zl_headerScaleImageHeight
{
    CGFloat headerImageHeight = [objc_getAssociatedObject(self, _cmd) floatValue];
    
    return headerImageHeight == 0?oriImageH:headerImageHeight;
}

- (void)setHeadStr:(NSString *)headStr
{
    oriImageH = 200.f;
}

// 属性：zl_headerImage
- (UIImage *)zl_headerScaleImage
{
    return self.zl_headerImageView.image;
}

// 设置头部imageView的图片
- (void)setZl_headerScaleImage:(UIImage *)zl_headerScaleImage
{
    self.zl_headerImageView.image = zl_headerScaleImage;
    
    // 初始化头部视图
    [self setupHeaderImageView];
    
}

// 设置头部视图的位置
- (void)setupHeaderImageViewFrame
{
    self.zl_headerImageView.frame = CGRectMake(0 , 0, self.bounds.size.width , self.zl_headerScaleImageHeight);
    
}

// 初始化头部视图
- (void)setupHeaderImageView
{
    
    // 设置头部视图的位置
    [self setupHeaderImageViewFrame];
    
    // KVO监听偏移量，修改头部imageView的frame
    if (self.zl_isInitial == NO) {
        
        [self addObserver:self forKeyPath:ZLKeyPath(self, contentOffset) options:NSKeyValueObservingOptionNew context:nil];
        
        self.zl_isInitial = YES;
    }
}

#pragma mark - 观察者模式kvc
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    // 获取当前偏移量
    CGFloat offsetY = self.contentOffset.y;
    
    if (offsetY < 0) {
        
        self.zl_headerImageView.frame = CGRectMake(offsetY, offsetY, self.bounds.size.width - offsetY * 2, self.zl_headerScaleImageHeight - offsetY);
        
    } else {
        
        self.zl_headerImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.zl_headerScaleImageHeight);
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.zl_isInitial) { // 初始化过，就表示有监听contentOffset属性，才需要移除
        [self removeObserver:self forKeyPath:ZLKeyPath(self, contentOffset)];
    }
}

@end
