//
//  MRTagLabel.m
//  JustJoke
//
//  Created by Asuna on 15/8/26.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRTagLabel.h"

@implementation MRTagLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:15];
        self.backgroundColor = MRTagBackgroundColor;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self sizeToFit];
    
    self.width += 2 * SmallMargin;
    self.height = MRTagHeight;
}

@end
