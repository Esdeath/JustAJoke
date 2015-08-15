//
//  UIBarButtonItem+MRExtension.h
//  JustJoke
//
//  Created by Asuna on 15/8/15.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MRExtension)
+(instancetype)itemWithTarget:(id)target action:(SEL)action image:(NSString*)image highLightImage:(NSString*)highLightImage;
@end
