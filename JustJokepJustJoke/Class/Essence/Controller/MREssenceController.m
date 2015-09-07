//
//  MREssenceController.m
//  JustJoke
//
//  Created by Asuna on 15/8/15.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MREssenceController.h"
#import "MRRecommendTagsController.h"

#import "MRTitleButton.h"

#import "MRAllViewController.h"
#import "MRVideoViewController.h"
#import "MRVoiceViewController.h"
#import "MRPictureViewController.h"
#import "MRWordViewController.h"

@interface MREssenceController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIView *topView;

@property (strong, nonatomic) MRTitleButton *lastClickedButton;
@property (strong, nonatomic) NSMutableArray *arrayButtonTitle;
@property (strong, nonatomic) NSMutableArray *titleButtons;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation MREssenceController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupAllViewControllers];
    [self setupAllView];
    
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
}

#pragma mark - setup
- (void)setupNavBar
{
    self.view.backgroundColor = MRGlobalBackgroundColor;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftBarButtonClick) image:@"MainTagSubIcon" highLightImage:@"MainTagSubIconClick"];
}

-(void)setupAllView
{
    [self.view addSubview:self.topView];

    //添加顶部按钮
    for (NSInteger i = 0; i < self.arrayButtonTitle.count; i++) {
        MRTitleButton *titleButton = [MRTitleButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat buttonWidth = self.topView.width/5;
        CGFloat buttonHeight = self.topView.height;
        CGFloat buttonX = i*buttonWidth;
        CGFloat buttonY = 0;
        
        titleButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        titleButton.tag = i;
        [titleButton setTitle:self.arrayButtonTitle[i] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleButtons addObject:titleButton];
        [self.topView addSubview:titleButton];
        
        if (i == 0) {
            titleButton.selected = YES;
            
            self.lastClickedButton = titleButton;
            self.bottomView.width = titleButton.titleLabel.width;
            self.bottomView.centerX = titleButton.centerX;
        }
    }

}

-(void)setupAllViewControllers
{
    MRAllViewController *all = [[MRAllViewController alloc]init];
    all.title = self.arrayButtonTitle[0];
    [self addChildViewController:all];
    
    MRVideoViewController *video = [[MRVideoViewController alloc]init];
    all.title = self.arrayButtonTitle[1];
    [self addChildViewController:video];

    MRVoiceViewController *voice = [[MRVoiceViewController alloc]init];
    all.title = self.arrayButtonTitle[2];
    [self addChildViewController:voice];

    MRPictureViewController *picture = [[MRPictureViewController alloc]init];
    all.title = self.arrayButtonTitle[3];
    [self addChildViewController:picture];

    MRWordViewController *word = [[MRWordViewController alloc]init];
    all.title = self.arrayButtonTitle[4];
    [self addChildViewController:word];
    
    self.scollView.contentSize = CGSizeMake(self.arrayButtonTitle.count*self.scollView.width, self.scollView.height);
    
    
}

#pragma mark - UITableViewDelegate

/**
 *  滚动完毕就会调用（如果不是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *willShowChildVc = self.childViewControllers[index];
    
    // 如果这个子控制器的view已经添加过了，就直接返回
    if (willShowChildVc.isViewLoaded) return;
    
    // 添加子控制器的view
    willShowChildVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowChildVc.view];
}

/**
 *  滚动完毕就会调用（如果是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / scrollView.width;
    // 点击对应的按钮
    [self titleButtonClick:self.titleButtons[index]];
    
    // 添加子控制器的view
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - CustomDelegate

#pragma mark - event response
-(void)leftBarButtonClick
{
    MRRecommendTagsController *recommendTags = [[MRRecommendTagsController alloc]init];
    
    [self.navigationController pushViewController:recommendTags animated:YES];
    
}

-(void)titleButtonClick:(MRTitleButton*)titleButton
{
    self.lastClickedButton.selected = NO;
    titleButton.selected = YES;
    self.lastClickedButton = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.bottomView.centerX = titleButton.centerX;
        self.bottomView.width = titleButton.titleLabel.width;
    }];
    
    // 让scrollView滚动到对应的位置(不要去修改contentOffset的y值)
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];

    
}
#pragma mark - private methods

#pragma mark - getters and setters

- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc]init];
        _topView.frame = CGRectMake(0, kStatusBarHeight + kTopBarHeight, self.view.width, kButtonViewHeight);
        _topView.backgroundColor = RgbColorA(255, 255, 255, 0.5);
    }

    return _topView;
}

- (UIView *)bottomView
{
    if (_bottomView == nil) {
        // 标题底部的指示线
        UIView *bottomView = [[UIView alloc] init];
        bottomView.height = 1;
        bottomView.y = self.topView.height - bottomView.height;
        
        bottomView.backgroundColor = [UIColor redColor];
        [self.topView addSubview:bottomView];
        _bottomView = bottomView;
    }
    return _bottomView;
}

- (NSMutableArray *)arrayButtonTitle
{
    if (_arrayButtonTitle == nil) {
        _arrayButtonTitle = [NSMutableArray array];
        NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
        _arrayButtonTitle = [titles mutableCopy];
    }
    
    return _arrayButtonTitle;
}

- (NSMutableArray *)titleButtons
{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (UIScrollView *)scollView
{
    if (_scrollView == nil) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        scrollView.delegate = self;
        //scrollView.backgroundColor = [UIColor blueColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

@end
