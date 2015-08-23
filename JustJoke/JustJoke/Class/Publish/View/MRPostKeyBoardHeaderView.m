//
//  MRPostKeyBoardHeaderView.m
//  JustJoke
//
//  Created by Asuna on 15/8/22.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRPostKeyBoardHeaderView.h"

@interface MRPostKeyBoardHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic,strong) NSMutableArray *arrayButton;

@property (nonatomic,strong) UIButton *plusButton ;
@end

@implementation MRPostKeyBoardHeaderView
- (void)awakeFromNib
{
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusClick:) forControlEvents:UIControlEventTouchUpInside];
    //如果控件没有设置frame，就尽量用sizeToFit
    [plusButton sizeToFit];
    [self.headerView addSubview:plusButton];
    self.plusButton = plusButton;
}

-(void)plusClick:(UIButton*)sender
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.plusButton.x = 0;
    self.plusButton.y = 0;
}
@end
