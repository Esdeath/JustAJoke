//
//  MRPlaceholderTextView.m
//  JustJoke
//
//  Created by Asuna on 15/8/22.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRPlaceholderTextView.h"


@interface MRPlaceholderTextView ()
@property (nonatomic,strong) UILabel *placeholderLabel;
@end

@implementation MRPlaceholderTextView

- (UILabel *)placeholderLabel
{
    if (_placeholderLabel == nil) {
        UILabel *label = [UILabel label];
        label = [UILabel label];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentLeft;
        label.x = 5;
        label.y = 6;
        
        [self addSubview:label];
        _placeholderLabel = label;
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

-(void)textDidChange
{
    self.placeholderLabel.hidden = self.hasText;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
   
    self.placeholderLabel.width = self.width;
    
    [self.placeholderLabel sizeToFit];
    
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderLabel.text = self.placeholder;
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = self.placeholderColor;
    [self setTintColor:placeholderColor];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    self.placeholderLabel.hidden = self.hasText;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    self.placeholderLabel.hidden = self.hasText;
}
@end
