//
//  MRAddTagsController.h
//  JustJoke
//
//  Created by Asuna on 15/8/23.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRAddTagsController : UIViewController

//上一个界面传过来的tags
@property (nonatomic,strong) NSArray *arrayTags;

/** 这个block的作用：传递标签数据给上一个界面 */
@property (nonatomic, copy) void (^getTagsBlock)(NSArray *tags);

@end
