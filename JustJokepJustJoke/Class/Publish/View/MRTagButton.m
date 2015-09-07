//
//  MRTagButton.m
//  JustJoke
//
//  Created by Asuna on 15/8/26.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRTagButton.h"

@implementation MRTagButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.backgroundColor = MRTagBackgroundColor;
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 计算完毕
    [self sizeToFit];
    
    // 调整
    self.height = MRTagHeight;
    self.width += 3 * SmallMargin;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = SmallMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + SmallMargin;
}

@end
