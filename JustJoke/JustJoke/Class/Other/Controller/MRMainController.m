//
//  MRMainController.m
//  JustJoke
//
//  Created by Asuna on 15/8/15.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRMainController.h"

#import "MREssenceController.h"
#import "MRFriendTrendsController.h"
#import "MRNewController.h"
#import "MRMeController.h"

#import "MRMainNavController.h"

#import "MRTabBar.h"
@interface MRMainController ()

@end

@implementation MRMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpItemAttributes];
    
    //设置子控制器
    [self setUpAllChildViewControllers];
    
    //设置tabbar
    [self setUpTabBar];
}


-(void)setUpTabBar
{
    //readonly 只能通过KVC赋值
    //self.tabBar = [[MRTabBar alloc]init];
    [self setValue:[[MRTabBar alloc]init] forKeyPath:MRKeyPath(self, tabBar)];
    
}

-(void)setUpItemAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    dict1[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dict1[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:dict1 forState:UIControlStateSelected];
    //[item setTintColor:[UIColor redColor]];
    //[item setBarTintColor:[UIColor redColor]];
}


-(void)setUpAllChildViewControllers
{
    MREssenceController *essence = [[MREssenceController alloc]init];
    [self setUpWithController:essence title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    MRNewController *new = [[MRNewController alloc]init];
    [self setUpWithController:new title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    MRFriendTrendsController *friend = [[MRFriendTrendsController alloc]init];
    [self setUpWithController:friend title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    MRMeController *me = [[MRMeController alloc]init];
    [self setUpWithController:me title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    
}

-(void)setUpWithController:(UIViewController*)vc title:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage
{
    MRMainNavController *nav = [[MRMainNavController alloc]initWithRootViewController:vc];
    
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
