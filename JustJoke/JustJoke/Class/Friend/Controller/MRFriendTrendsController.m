//
//  MRFriendController.m
//  JustJoke
//
//  Created by Asuna on 15/8/15.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRFriendTrendsController.h"

@interface MRFriendTrendsController ()

@end

@implementation MRFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MRGlobalBackgroundColor;
    
    // 设置导航栏中间的文字
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftBarButtonClick) image:@"friendsRecommentIcon" highLightImage:@"friendsRecommentIcon-click"];
}

- (void)leftBarButtonClick {
    MRLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
