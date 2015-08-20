//
//  MRMeFooterView.m
//  JustJoke
//
//  Created by Asuna on 15/8/19.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRMeFooterView.h"
#import "MRMeButtonModel.h"
#import "MRMeButton.h"
@interface MRMeFooterView ()


@end
@implementation MRMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";

        [[MRHttpTool shareHttpTool] getWithURLString:urlExtension params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            MRLog(@"%@",responseObject);
            NSArray* arrayModel = [MRMeButtonModel objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSquares:arrayModel];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
    }
    
    return self;
}

/**
 * 创建方块
 */
- (void)createSquares:(NSArray *)arrayModel
{
    // 一行最多4列
    const int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = Main_Screen_Width / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<arrayModel.count; i++) {
        MRMeButton *button = [MRMeButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.buttonModel = arrayModel[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    
    NSUInteger rows = (arrayModel.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)buttonClick:(MRMeButton *)button
{
//    if (![button.square.url hasPrefix:@"http"]) return;
//    
//    XMGWebViewController *web = [[XMGWebViewController alloc] init];
//    web.url = button.square.url;
//    web.title = button.square.name;
//    
//    // 取出当前的导航控制器
//    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
//    [nav pushViewController:web animated:YES];
}


@end
