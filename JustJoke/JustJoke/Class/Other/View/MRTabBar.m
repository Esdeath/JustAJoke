//
//  MRTabBar.m
//  JustJoke
//
//  Created by Asuna on 15/8/15.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRTabBar.h"
#import "MRPublishController.h"
#import "MRMainNavController.h"
#import "MRPostMessageController.h"
@interface MRTabBar ()

@property (nonatomic,weak) UIButton *publishButton;
@property (strong, nonatomic) UIImageView *imageCenter;

@end

@implementation MRTabBar

+ (void)initialize
{
    MRTabBar *tabbar = [MRTabBar appearance];
    [tabbar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

-(UIImageView *)imageCenter
{
    if (_imageCenter == nil) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_mainbtn_bg"]];
        [imageView sizeToFit];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _imageCenter = imageView;
    }
    
    return _imageCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
      //  self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    
    return self;
}


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
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[MRPublishController alloc]init] animated:YES completion:nil];
    
    
    
    //[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[MRMainNavController alloc] initWithRootViewController:[[MRPostMessageController alloc]init] ] animated:YES completion:nil];
    
}


/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageCenter.centerX = self.width*0.5;
    self.imageCenter.centerY = self.height*0.5 - 5;
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
