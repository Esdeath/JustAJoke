//
//  MRBaseViewController.m
//  JustJoke
//
//  Created by Asuna on 15/9/3.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRBaseViewController.h"
#import "MRTopicCell.h"
#import "MRTopic.h"
#import "MRComment.h"

#import "MRCommentViewController.h"
#import "MRNewController.h"

@interface MRBaseViewController ()

@property (strong, nonatomic) MRHttpTool *httpTool;
@property (strong, nonatomic) NSMutableArray *topics;
@property (strong, nonatomic) NSString *maxtime;

- (NSString *)aParam;
@end

static NSString* const MRCellID = @"MRTopicCell";

@implementation MRBaseViewController

- (MRTopicType)type {return 0;}
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupRefresh];
}

#pragma mark - setup

- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MRTopicCell class]) bundle:nil] forCellReuseIdentifier:MRCellID];
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = MRTitlesViewH + kTopBarHeight + kStatusBarHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = MRTagBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.tableView.estimatedRowHeight = 200;
}

-(void)setupRefresh
{
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.header.automaticallyChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    //上拉刷新
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 加载数据
- (NSString *)aParam
{
    // isKindOfClass:是否为这种类型，或者继承自这种类型
    return [self.parentViewController isKindOfClass:[MRNewController class]] ? @"newlist" : @"list";
}
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MRTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:MRCellID];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 模型数据
    MRTopic *topic = self.topics[indexPath.row];
    
    // 返回这个模型数据对应的cell高度
    return topic.cellHeight;
}
// 懒加载：用到时再去加载
// 饿加载

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MRCommentViewController *commentVc = [[MRCommentViewController alloc] init];
    commentVc.topic = self.topics[indexPath.row];
}
#pragma mark - CustomDelegate

#pragma mark - event response
#pragma mark - private methods
-(void)loadNewTopics
{
    // 取消之前的所有请求
    [self.httpTool.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    // 发送请求
    WEAKSELF;
    [self.httpTool getWithURLString:urlExtension params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 存储maxtime：方便加载下一页的数据
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        weakSelf.topics = [MRTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
        // 如果是取消了任务，就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        [SVProgressHUD showErrorWithStatus:@"下拉刷新失败"];
    }];
}


- (void)loadMoreTopics
{
    // 取消之前的所有请求
    [self.httpTool.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    
    // 发送请求
    WEAKSELF;
    [self.httpTool getWithURLString:urlExtension params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 存储maxtime：方便加载下一页的数据
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        NSArray *newTopics = [MRTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 将newTopics中的所有元素添加到weakSelf.topics中
        [weakSelf.topics addObjectsFromArray:newTopics];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];
        // 如果是取消了任务，就直接返回
        if (error.code == NSURLErrorCancelled) return;
        [SVProgressHUD showErrorWithStatus:@"上拉刷新失败"];
    }];
}
#pragma mark - getters and setters
- (MRHttpTool *)httpTool
{
    if (_httpTool == nil) {
        _httpTool = [MRHttpTool shareHttpTool];
    }
    return _httpTool;
}

@end

