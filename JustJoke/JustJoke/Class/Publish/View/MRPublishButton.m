//
//  MRPublishButton.m
//  JustJoke
//
//  Created by Asuna on 15/8/21.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRPublishButton.h"

@implementation MRPublishButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setUp];
}

- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    static const int Margin2 = 20;
    
    CGFloat imageViewX = Margin2;
    CGFloat imageViewY = 0;
    CGFloat imageViewWidth = self.width - 2*Margin2;
    CGFloat imageViewHeight = imageViewWidth;
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    
    CGFloat labelX = 0;
    CGFloat labelY = imageViewHeight;
    CGFloat labelWidth = self.width;
    CGFloat labelHeight = self.height - imageViewWidth;
    
    self.titleLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
    
}

@end
