//
//  MRProgressView.m
//  JustJoke
//
//  Created by Asuna on 15/9/6.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRProgressView.h"

@implementation MRProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 5;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress
{
    [super setProgress:progress];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}


@end
