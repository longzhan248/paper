//
//  YcKeyBoardView.m
//  KeyBoardAndTextView
//
//  Created by zzy on 14-5-28.
//  Copyright (c) 2014年 zzy. All rights reserved.
//

#import "YcKeyBoardView.h"

@interface YcKeyBoardView()<UITextViewDelegate>
@property (nonatomic,assign) CGFloat textViewWidth;
@property (nonatomic,assign) BOOL isChange;
@property (nonatomic,assign) BOOL reduce;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@end

@implementation YcKeyBoardView

- (id)initWithFrame:(CGRect)frame tipString:(NSString *)tipString
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self initTextView:tipString];
    }
    return self;
}
-(void)initTextView:(NSString *)tipPlaceholder
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
        _bgView.layer.borderColor = kUIColorFromRGB(LINE_GRAY).CGColor;
        _bgView.layer.borderWidth = 0.5;
        _bgView.backgroundColor = kUIColorFromRGB(0xf7f7f7);
        [self addSubview:_bgView];
    }
    
//    CGFloat textX=kStartLocation*0.5;
    if (_textView == nil) {
        self.textView=[[CustomTextView alloc]init];
        self.textView.delegate=self;
        self.textView.backgroundColor=kUIColorFromRGB(WHITE);
        self.textView.layer.cornerRadius = 5;
        self.textView.layer.borderColor = kUIColorFromRGB(LINE_GRAY).CGColor;
        self.textView.layer.borderWidth = 0.5;
        self.textView.delegate = self;
        
        self.textView.hidden = NO;
        self.textView.layer.masksToBounds = YES;
        self.textView.font = FONT_PING_REGULAR(14.0f);
        self.textView.returnKeyType = UIReturnKeySend;
        if ([tipPlaceholder isEqualToString:@"说点什么..."]) {
             self.textViewWidth = ScreenWidth-20;
            self.textView.frame = CGRectMake(10, 8,self.textViewWidth, 33);
        }else{
             self.textViewWidth = ScreenWidth-50;
            self.textView.frame = CGRectMake(10, 6,self.textViewWidth, 33);
        }
    }
    self.textView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0);
    self.textView.scrollEnabled = NO;
    
    if (_labelPlaceholder==nil) {
        _labelPlaceholder = [[UILabel alloc] initWithFrame:CGRectZero];
        _labelPlaceholder.textColor = kUIColorFromRGB(GRAY);
        _labelPlaceholder.backgroundColor = [UIColor clearColor];
        _labelPlaceholder.font = FONT_PING_REGULAR(13.0f);
    }
    _labelPlaceholder.frame = CGRectMake(8, 0, 150, 32);
    _labelPlaceholder.hidden = NO;
    _labelPlaceholder.text = tipPlaceholder;
    [_bgView addSubview:self.textView];
    [_textView addSubview:_labelPlaceholder];
}

//光标高度
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect originalRect = [_textView caretRectForPosition:position];
    originalRect.size.height = 18.;
    return originalRect;
}


#pragma mark -
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (![textView.text isEqualToString:@""]) {
        _labelPlaceholder.hidden = YES;
    }
    if ([textView.text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _labelPlaceholder.hidden = NO;
    }
    
    if ([text isEqualToString:@"\n"]){
        if([self.delegate respondsToSelector:@selector(keyBoardViewHide: textView:)]){
            
            [self.delegate keyBoardViewHide:self textView:self.textView];
        }
        return NO;
    }
    
    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger res = 100-[new length];
    
    if(res >= 0){
        return YES;
    }else{
        if (res<0) {
            _textView.text = [new substringToIndex:100];
            return NO;
        }
        return NO;
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
      NSString *content = textView.text;
    
      CGSize contentSize=[content sizeWithFont:FONT_PING_REGULAR(14.0f)];
    
      if(contentSize.width>self.textViewWidth){
          
          if(!self.isChange){
              
              textView.scrollEnabled = YES;
              CGRect keyFrame=self.frame;
              self.originalKey=keyFrame;
              keyFrame.size.height+=keyFrame.size.height;
              keyFrame.origin.y-=keyFrame.size.height*0.05;
              self.frame=keyFrame;
              
              CGRect textFrame=self.textView.frame;
              self.originalText = textFrame;
              textFrame.size.height += textFrame.size.height*0.2;
              _bgView.height += textFrame.size.height*0.2;
              self.textView.frame = textFrame;
              self.isChange=YES;
              self.reduce=YES;
            }
      }
    
    if(contentSize.width<=self.textViewWidth){
        
        if(self.reduce){
            textView.scrollEnabled = NO;
            self.frame = self.originalKey;
            self.textView.frame = self.originalText;
            self.isChange = NO;
            self.reduce = NO;
       }
    }
    if ([textView.text isEqualToString:@""]||textView.text==nil) {
        _labelPlaceholder.hidden = NO;
        textView.scrollEnabled = NO;
    }else{
        _labelPlaceholder.hidden = YES;
    }
    //---------新增
//    textView.contentOffset = (CGPoint){.x =0, .y = -3};
}

@end
