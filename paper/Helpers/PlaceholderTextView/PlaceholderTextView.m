//
//  PlaceholderTextView.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView()<UITextViewDelegate>
{
    UILabel *PlaceholderLabel;
}

@end

@implementation PlaceholderTextView

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [PlaceholderLabel removeFromSuperview];
    
}

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}


- (void)awakeFromNib {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
    
    float left=7,top=1,hegiht=30;
    
    self.placeholderColor = kUIColorFromRGB(GRAY);
    PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                               , CGRectGetWidth(self.frame)-2*left, hegiht)];
    PlaceholderLabel.font=self.placeholderFont?self.placeholderFont:self.font;
    PlaceholderLabel.textColor=self.placeholderColor;
    [self addSubview:PlaceholderLabel];
    PlaceholderLabel.text=self.placeholder;
    
    [super awakeFromNib];
}
//光标高度
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect originalRect = [super caretRectForPosition:position];
    originalRect.size.height = 18.;
    return originalRect;
}

-(void)setPlaceholderFont:(UIFont *)placeholderFont{
    PlaceholderLabel.font=placeholderFont;
    _placeholderFont =placeholderFont;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    else
        PlaceholderLabel.text=placeholder;
    _placeholder=placeholder;
    
    
}

-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        PlaceholderLabel.hidden=YES;
    }
    else{
        PlaceholderLabel.hidden=NO;
    }
    
    
}

@end
