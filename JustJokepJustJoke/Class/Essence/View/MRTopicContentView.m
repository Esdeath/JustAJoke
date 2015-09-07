//
//  MRTopicContentView.m
//  JustJoke
//
//  Created by Asuna on 15/9/6.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRTopicContentView.h"
#import "MRTopic.h"
#import "MRShowPictureViewController.h"

@interface MRTopicContentView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MRTopicContentView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 监听图片点击
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
}

- (void)imageClick
{
    if (self.topic.pictureProgress < 1.0) return;
    
    MRShowPictureViewController *sp = [[MRShowPictureViewController alloc] init];
    sp.topic = self.topic;
    [self.window.rootViewController presentViewController:sp animated:YES completion:nil];
}


@end
