//
//  MRMeController.m
//  JustJoke
//
//  Created by Asuna on 15/8/15.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRMeController.h"
#import "MRSettingController.h"
#import "MRMeLoginCell.h"

#import "MRMeFooterView.h"
static NSString* const ID = @"cell";

@interface MRMeController ()

@end

@implementation MRMeController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpNav];
    [self setUpTableView];
}

-(void)setUpNav
{
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithTarget:self action:@selector(settingClick) image:@"mine-setting-icon" highLightImage:@"mine-setting-icon-click"];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithTarget:self action:@selector(moonClick) image:@"mine-moon-icon" highLightImage:@"mine-moon-icon-click"];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}
- (void)settingClick
{
    MRSettingController *setting = [[MRSettingController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)moonClick
{
    MRLogFunc;
}


-(void)setUpTableView
{
    self.view.backgroundColor = MRGlobalBackgroundColor;
    
    [self.tableView registerClass:[MRMeLoginCell class] forCellReuseIdentifier:ID];
    [self.tableView setContentInset:UIEdgeInsetsMake(Margin - 30, 0, 0, 0)];

    self.tableView.sectionHeaderHeight = 0;

    
    self.tableView.tableFooterView = [[MRMeFooterView alloc]init];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MRMeLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
