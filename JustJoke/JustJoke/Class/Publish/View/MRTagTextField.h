//
//  MRTagTextField.h
//  JustJoke
//
//  Created by Asuna on 15/8/26.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRTagTextField : UITextField
/** 点击删除键就会调用的block，这个block是在删除文字之前调用 */
@property (nonatomic, copy) void (^beforeDeleteBackwardBlock)();
@end
