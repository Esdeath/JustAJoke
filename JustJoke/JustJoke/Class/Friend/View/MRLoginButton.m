//
//  MRLoginButton.m
//  JustJoke
//
//  Created by Asuna on 15/8/17.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRLoginButton.h"

@implementation MRLoginButton

- (void)awakeFromNib
{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
    
}

-(void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];

    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}


@end
