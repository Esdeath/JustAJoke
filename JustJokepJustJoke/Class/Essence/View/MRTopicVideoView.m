//
//  MRTopicVideoView.m
//  JustJoke
//
//  Created by Asuna on 15/9/6.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRTopicVideoView.h"
#import "MRTopic.h"

@interface MRTopicVideoView()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation MRTopicVideoView

- (void)setTopic:(MRTopic *)topic
{
    [super setTopic:topic];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        topic.pictureProgress = 1.0;
    }];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd人播放", topic.playcount];
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.videotime / 60, topic.videotime % 60];
}
@end