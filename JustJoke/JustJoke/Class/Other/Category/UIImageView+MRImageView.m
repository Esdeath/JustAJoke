//
//  UIImageView+MRImageView.m
//  JustJoke
//
//  Created by Asuna on 15/8/17.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "UIImageView+MRImageView.h"

@implementation UIImageView (MRImageView)
-(void)setHeader:(NSString *)url placeHold:(NSString *)placeHold
{
    UIImage *placeholdImage = [[UIImage imageNamed:placeHold] imageCircle];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholdImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image imageCircle] : placeholdImage;
    }];
}
@end
