//
//  MRTitleButton.m
//  JustJoke
//
//  Created by Asuna on 15/9/3.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRTitleButton.h"

@implementation MRTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.titleLabel sizeToFit];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{}
@end
