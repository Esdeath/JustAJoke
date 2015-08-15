//
//  UIBarButtonItem+MRExtension.m
//  JustJoke
//
//  Created by Asuna on 15/8/15.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "UIBarButtonItem+MRExtension.h"

@implementation UIBarButtonItem (MRExtension)
+(instancetype)itemWithTarget:(id)target action:(SEL)action image:(NSString*)image highLightImage:(NSString*)highLightImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    return [[self alloc]initWithCustomView:button];
}
@end
