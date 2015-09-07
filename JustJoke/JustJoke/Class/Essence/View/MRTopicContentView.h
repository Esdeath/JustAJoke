//
//  MRTopicContentView.h
//  JustJoke
//
//  Created by Asuna on 15/9/6.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MRTopic;
@interface MRTopicContentView : UIView
{
    __weak UIImageView *_imageView;
}
/** 帖子模型 */
@property (nonatomic, strong) MRTopic *topic;
@end
