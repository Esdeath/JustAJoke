//
//  MRCommentViewController.m
//  JustJoke
//
//  Created by Asuna on 15/9/4.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRCommentViewController.h"
#import "MRCommentHeader.h"
#import "MRTopic.h"
#import "MRTopicCell.h"
#import "MRComment.h"
#import "MRCommentCell.h"

@interface MRCommentViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 保存最热评论 */
@property (nonatomic, strong) id top_cmt;

/** 管理者 */
@property (nonatomic, weak) MRHttpTool *manager;

/** 最热评论数据 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论数据 */
@property (nonatomic, strong) NSMutableArray *lastestComments;
@end

@implementation MRCommentViewController

static NSString * const MRCommentCellId = @"comment";
static NSString * const MRCommentHeaderId = @"comment-header";

#pragma mark - 懒加载
- (MRHttpTool *)manager
{
    if (!_manager) {
        _manager = [MRHttpTool shareHttpTool];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
    
    [self setupHeader];
    
    [self setupRefresh];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = MRTagBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MRCommentCellId class]) bundle:nil] forCellReuseIdentifier:MRCommentCellId];
    [self.tableView registerClass:[MRCommentHeader class] forHeaderFooterViewReuseIdentifier:MRCommentHeaderId];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

- (void)setupNav
{
    self.title = @"评论";
    // 设置导航栏右边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:nil action:nil image:@"comment_nav_item_share_icon" highLightImage:@"comment_nav_item_share_icon_click"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupHeader
{
    // 去除最热评论
    if (self.topic.top_cmt) {
        self.top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        self.topic.cellHeight = 0;
    }
    
    // header
    UIView *header = [[UIView alloc] init];
    
    // header内部的cell
     MRTopicCell   *cell = [MRTopicCell viewFromNib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, Main_Screen_Width , self.topic.cellHeight);
    [header addSubview:cell];
    
    // header的高度
    header.height = cell.height + Margin;
    
    self.tableView.tableHeaderView = header;
}

- (void)dealloc
{
    [self.manager invalidateSessionCancelingTasks:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.top_cmt) {
        self.topic.top_cmt = self.top_cmt;
        self.topic.cellHeight = 0;
    }
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    self.bottomSpace.constant = Main_Screen_Height - keyboardY;
    
    // 动画时间
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 加载数据
- (void)loadNewComments
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    
    // 发送请求
    WEAKSELF;
    
    [self.manager getWithURLString:urlExtension params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            // 结束刷新
            [weakSelf.tableView.header endRefreshing];
            return;
        }
        
        // 数据处理
        weakSelf.hotComments = [MRComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        weakSelf.lastestComments = [MRComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
        
        // 所有数据加载完毕
        if (weakSelf.lastestComments.count >= [responseObject[@"total"] intValue]) {
            weakSelf.tableView.footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    }];
    
}

- (void)loadMoreComments
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = [[self.lastestComments lastObject] ID];
    
    // 发送请求
    WEAKSELF;
    [self.manager getWithURLString:urlExtension params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            weakSelf.tableView.footer.hidden = YES;
            return;
        }
        
        // 数据处理
        NSArray *newComments = [MRComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.lastestComments addObjectsFromArray:newComments];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        if (weakSelf.lastestComments.count >= [responseObject[@"total"] intValue]) { // 所有数据加载完毕
            weakSelf.tableView.footer.hidden = YES;
        } else {
            [weakSelf.tableView.footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count) return 2;
    if (self.lastestComments.count) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.hotComments.count) return self.hotComments.count;
    return self.lastestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MRComment *comment = nil;
    if (indexPath.section == 0 && self.hotComments.count) {
        comment = self.hotComments[indexPath.row];
    } else {
        comment = self.lastestComments[indexPath.row];
    }
    
    MRCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:MRCommentCellId];
    cell.comment = comment;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MRCommentHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:MRCommentHeaderId];
    if (section == 0 && self.hotComments.count) {
        header.text = @"最热评论";
    } else {
        header.text = @"最新评论";
    }
    return header;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)resignFirstResponder
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    menu.menuItems = nil;
    return [super resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    // 如果之间已经设置过了，就直接返回，不显示
    if (menu.menuItems) {
        menu.menuItems = nil;
        return;
    }
    
    [self becomeFirstResponder];
    
    // cell
    MRCommentCell *cell = (MRCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    // 设置显示的范围
    [menu setTargetRect:CGRectMake(0, cell.height * 0.5, cell.width, 1) inView:cell];
    // 添加自定义菜单
    menu.menuItems = @[
                       [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding)],
                       [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply)],
                       [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(warning)]
                       ];
    [menu setMenuVisible:YES animated:YES];
    
}

- (void)ding
{
    NSLog(@"%s", __func__);
}

- (void)reply
{
    NSLog(@"%s", __func__);
}

- (void)warning
{
    NSLog(@"%s", __func__);
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end

