//
//  UIImage+MRImage.m
//  JustJoke
//
//  Created by Asuna on 15/8/17.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "UIImage+MRImage.h"

@implementation UIImage (MRImage)
-(UIImage*)imageCircle
{
    UIGraphicsBeginImageContext(self.size);
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:self.size.width/2];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}
@end
