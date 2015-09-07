//
//  MRPostKeyBoardHeaderView.m
//  JustJoke
//
//  Created by Asuna on 15/8/22.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRPostKeyBoardHeaderView.h"
#import "MRAddTagsController.h"
#import "MRMainNavController.h"
#import "MRTagLabel.h"
@interface MRPostKeyBoardHeaderView ()
@property (weak, nonatomic ) IBOutlet  UIView         *headerView;
@property (nonatomic,strong) NSMutableArray *arrayButton;
@property (nonatomic,strong) UIButton *plusButton                 ;
@property (nonatomic,strong) NSMutableArray *tagLabels;
@end

@implementation MRPostKeyBoardHeaderView

- (NSMutableArray *)tagLabels
{
    if (_tagLabels == nil) {
        _tagLabels = [NSMutableArray array];
    }
    
    return _tagLabels;
}

- (void)awakeFromNib
{
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusClick:) forControlEvents:UIControlEventTouchUpInside];
    //如果控件没有设置frame，就尽量用sizeToFit
    [plusButton sizeToFit];
    [self.headerView addSubview:plusButton];
    self.plusButton      = plusButton;
    
    [self createTagLabels:@[@"吐槽", @"糗事"]];
   
}

-(void)plusClick:(UIButton*)sender
{
    MRAddTagsController *addTagController = [[MRAddTagsController alloc]init];
    WEAKSELF;
    [addTagController setGetTagsBlock:^(NSArray *array) {
        [weakSelf createTagLabels:array];
    }];
    
    addTagController.arrayTags = [self.tagLabels valueForKeyPath:@"text"];

    MRMainNavController *nav              = [[MRMainNavController alloc]initWithRootViewController:addTagController];

    //获得跟控制器
    UIViewController *rootController      = self.window.rootViewController;
    //获取当前被model出来的控制器
    UIViewController *postController      = rootController.presentedViewController;
   // [UIColor redColor]
    [postController presentViewController:nav animated:YES completion:nil];
}


/**
 *  根据传递回来的标签数据，创建对应个数的标签label
 */
- (void)createTagLabels:(NSArray *)tags
{
    // 删除以前的所有label
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    // 所有的标签文本
    for (int i = 0; i < tags.count; i++) {
        // 添加
        MRTagLabel *tagLabel = [[MRTagLabel alloc] init];
        tagLabel.text = tags[i];
        [self.headerView addSubview:tagLabel];
        [self.tagLabels addObject:tagLabel];
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 所有的标签文本
    for (int i = 0; i < self.tagLabels.count; i++) {
        // 添加
        MRTagLabel *tagLabel = self.tagLabels[i];
        
        // 计算
        if (i == 0) {
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else {
            MRTagLabel *previousTagLabel = self.tagLabels[i - 1];
            CGFloat rightWidth = self.headerView.width - CGRectGetMaxX(previousTagLabel.frame) - SmallMargin;
            if (rightWidth >= tagLabel.width) {
                tagLabel.y = previousTagLabel.y;
                tagLabel.x = CGRectGetMaxX(previousTagLabel.frame) + SmallMargin;
            } else {
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(previousTagLabel.frame) + SmallMargin;
            }
        }
    }
    
    // 加号按钮
    MRTagLabel *lastTagLabel = self.tagLabels.lastObject;
    CGFloat rightWidth = self.headerView.width - CGRectGetMaxX(lastTagLabel.frame) - SmallMargin;
    if (rightWidth >= self.plusButton.width) {
        self.plusButton.y = lastTagLabel.y;
        self.plusButton.x = CGRectGetMaxX(lastTagLabel.frame) + SmallMargin;
    } else {
        self.plusButton.x = 0;
        self.plusButton.y = CGRectGetMaxY(lastTagLabel.frame) + SmallMargin;
    }
    
    // 设置topView的尺寸
    self.headerView.height = CGRectGetMaxY(self.plusButton.frame) + SmallMargin;
    
    // 设置整个toolbar的高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.headerView.frame) + SmallMargin + 35;
    self.y += oldH - self.height;
}
@end
