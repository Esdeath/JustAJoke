//
//  MRTabBar.m
//  JustJoke
//
//  Created by Asuna on 15/8/15.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRTabBar.h"

@interface MRTabBar ()

@property (nonatomic,weak) UIButton *publishButton;

@end

@implementation MRTabBar

- (UIButton *)publishButton
{
    if (_publishButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        [button sizeToFit];
        [self addSubview:button];
        
        _publishButton = button;
    }
    
    return _publishButton;
}

-(void)publishClick
{
    MRLogFunc;
}


/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 发布按钮
    self.publishButton.centerX = self.width * 0.5;
    self.publishButton.centerY = self.height * 0.5;
    
    // 处理其他按钮
    CGFloat buttonW = self.width / 5;
    CGFloat i = 0;
    for (UIView *tabBarButton in self.subviews) {
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        tabBarButton.width = buttonW;
        tabBarButton.x = i * buttonW;
        if (i > 1) tabBarButton.x += buttonW;
        
        i++;
    }
}
@end
