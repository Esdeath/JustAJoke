//
//  MRTagTextField.m
//  JustJoke
//
//  Created by Asuna on 15/8/26.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRTagTextField.h"
#import <objc/runtime.h>
@implementation MRTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 先设置占位文字
        self.placeholder = @"多个标签用逗号或者换行隔开";
        
        // 修改占位文字颜色（有了占位文字，才能设置占位文字颜色）
        [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    }
    return self;
}

/**
 *  监听删除键，点击删除键，就会调用这个方法
 */
- (void)deleteBackward
{
    // 执行block
    !self.beforeDeleteBackwardBlock ? : self.beforeDeleteBackwardBlock();
    
    [super deleteBackward];
}


@end
