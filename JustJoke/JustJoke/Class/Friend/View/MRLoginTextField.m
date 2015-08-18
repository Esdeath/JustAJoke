//
//  MRLoginTextField.m
//  JustJoke
//
//  Created by Asuna on 15/8/17.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRLoginTextField.h"
#import <objc/runtime.h>
@implementation MRLoginTextField

-(void)awakeFromNib
{
    self.tintColor = [UIColor whiteColor];
    self.textColor = [UIColor whiteColor];
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
//
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:self.placeholder attributes:dict];
//    self.attributedPlaceholder = string;
//    unsigned int count = 0;
//    Ivar *ivar = NULL;
//    ivar =  class_copyIvarList([UITextField class], &count);
//    Ivar var;
//    for (int i = 0 ; i < count ; i++) {
//         var = ivar[i];
//        MRLog(@"%s",ivar_getName(var));
//    }
//    
    [self addTarget:self action:@selector(begin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(end) forControlEvents:UIControlEventEditingDidEnd];
    
    [self end];
    
}

-(void)begin
{
    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
}

-(void)end
{
    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
}
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    rect.size.height = self.font.lineHeight;
//    rect.origin.y = (self.height - rect.size.height) * 0.5;
//    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    attrs[NSFontAttributeName] = self.font;
//    [self.placeholder drawInRect:rect withAttributes:attrs];
//}

@end
