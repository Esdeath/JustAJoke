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
@interface MRMainController ()

@end

@implementation MRMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tabbar
    [self setUpTabBar];
        //设置子控制器
    [self setUpAllChildViewControllers];
}

-(void)setUpTabBar
{
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    dict1[NSForegroundColorAttributeName] = [UIColor blackColor];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
