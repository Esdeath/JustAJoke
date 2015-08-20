//
//  MRMeButton.m
//  JustJoke
//
//  Created by Asuna on 15/8/19.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRMeButton.h"
#import "MRMeButtonModel.h"
#import <SDWebImage/UIButton+WebCache.h>
@implementation MRMeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return self;
}

-(void)setButtonModel:(MRMeButtonModel *)buttonModel
{
    _buttonModel = buttonModel;
    
    [self setTitle:buttonModel.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:buttonModel.icon] forState:UIControlStateNormal];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}
@end
