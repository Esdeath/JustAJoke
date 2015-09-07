//
//  MRTopicCell.m
//  JustJoke
//
//  Created by Asuna on 15/9/5.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRTopicCell.h"

#import "MRUser.h"
#import "MRComment.h"
#import "MRTopic.h"

#import "MRTopicVideoView.h"
#import "MRTopicVoiceView.h"
#import "MRTopicPictureView.h"

@interface MRTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@property (weak, nonatomic) MRTopicPictureView *pictureView;
@property (weak, nonatomic) MRTopicVideoView *videoView;
@property (weak, nonatomic) MRTopicVoiceView *voiceView;

@end

@implementation MRTopicCell

- (MRTopicPictureView *)pictureView
{
    if (_pictureView == nil) {
        MRTopicPictureView *pictureView = [MRTopicPictureView viewFromNib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (MRTopicVideoView *)videoView
{
    if (_videoView == nil) {
        MRTopicVideoView *videoView = [MRTopicVideoView viewFromNib];
        [self.contentView addSubview:_videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (MRTopicVoiceView *)voiceView
{
    if (_voiceView == nil) {
        MRTopicVoiceView *voiceView = [MRTopicVoiceView viewFromNib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];

}

- (void)setTopic:(MRTopic *)topic
{
    _topic = topic;
    
    // 顶部数据
    [self.profileImageView setHeader:topic.profile_image placeHold:nil];
    self.nameLabel.text = topic.name;
    self.text_label.text = topic.text;
    self.createTimeLabel.text = topic.create_time;
    
    // 底部工具条
    [self setupToolbarButtonText:self.dingButton count:topic.ding title:@"赞"];
    [self setupToolbarButtonText:self.caiButton count:topic.cai title:@"踩"];
    [self setupToolbarButtonText:self.repostButton count:topic.repost title:@"分享"];
    [self setupToolbarButtonText:self.commentButton count:topic.comment title:@"评论"];
    
    // 最热评论
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
    // 中间的具体内容
    switch (topic.type) {
        case MRTopicTypeWord: { // 文字
            self.pictureView.hidden = YES;
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
            break;
        }
        case MRTopicTypePicture: { // 图片
            self.pictureView.hidden = NO;
            self.pictureView.frame = topic.contentFrame;
            self.pictureView.topic = topic;
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
            break;
        }
        case MRTopicTypeVoice: { // 声音
            self.pictureView.hidden = YES;
            self.voiceView.hidden = NO;
            self.voiceView.frame = topic.contentFrame;
            self.voiceView.topic = topic;
            self.videoView.hidden = YES;
            break;
        }
        case MRTopicTypeVideo: { // 视频
            self.pictureView.hidden = YES;
            self.voiceView.hidden = YES;
            self.videoView.hidden = NO;
            self.videoView.frame = topic.contentFrame;
            self.videoView.topic = topic;
            break;
        }
        default:break;
    }

}

/**
 *  设置工具条按钮文字
 *
 *  @param button 按钮
 *  @param count  数量
 *  @param title  数量为0时显示的文字
 */
- (void)setupToolbarButtonText:(UIButton *)button count:(NSInteger)count title:(NSString *)title
{
    if (count >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", count / 10000.0] forState:UIControlStateNormal];
    } else if (count > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", count] forState:UIControlStateNormal];
    } else {
        [button setTitle:title forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= Margin;
    frame.origin.y += Margin;
    
    [super setFrame:frame];
}

- (IBAction)moreClick {
    // UIAlertController == UIAlertView + UIActionSheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        MRLog(@"点击了取消按钮");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        MRLog(@"点击了收藏按钮");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        MRLog(@"点击了举报按钮");
    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
