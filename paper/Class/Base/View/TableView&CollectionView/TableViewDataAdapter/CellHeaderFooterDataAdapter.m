//
//  CellHeaderFooterDataAdapter.m
//  paper
//
//  Created by 詹龙 on 2018/9/29.
//  Copyright © 2018 longzhan. All rights reserved.
//

#import "CellHeaderFooterDataAdapter.h"

@implementation CellHeaderFooterDataAdapter

+ (instancetype)cellHeaderFooterDataAdapterWithReuseIdentifier:(NSString *)reuseIdentifier
                                                          data:(id)data
                                                        height:(CGFloat)height
                                                          type:(NSInteger)type {
    
    CellHeaderFooterDataAdapter *adapter = [[self class] new];
    adapter.reuseIdentifier                = reuseIdentifier;
    adapter.data                           = data;
    adapter.height                         = height;
    adapter.type                           = type;
    
    return adapter;
    
}

@end
