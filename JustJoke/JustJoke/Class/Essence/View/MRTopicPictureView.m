//
//  MRTopicPictureView.m
//  JustJoke
//
//  Created by Asuna on 15/9/6.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRTopicPictureView.h"
#import "MRProgressView.h"
#import "MRTopic.h"
@interface MRTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet MRProgressView *progressView;
@end
@implementation MRTopicPictureView

- (void)setTopic:(MRTopic *)topic
{
    [super setTopic:topic];
    
    // 覆盖进度
    self.progressView.progress = topic.pictureProgress;
    
    // 下载图片
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        self.progressView.progress = 1.0 * receivedSize / expectedSize;
        topic.pictureProgress = self.progressView.progress;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        topic.pictureProgress = 1.0;
        
        if (topic.isBigPicture == NO) return;
        
        // 将大图片 -> 小图片
        UIGraphicsBeginImageContext(_imageView.frame.size);
        
        [image drawInRect:CGRectMake(0, 0, _imageView.width, _imageView.width * topic.height / topic.width)];
        
        _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }];
    
    self.gifView.hidden = !topic.is_gif;
    self.seeBigButton.hidden = !topic.isBigPicture;
}
@end
