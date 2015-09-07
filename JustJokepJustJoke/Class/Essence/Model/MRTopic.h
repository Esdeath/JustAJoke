//
//  MRTopic.h
//  JustJoke
//
//  Created by Asuna on 15/9/5.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MRTopicTypeAll = 1,
    MRTopicTypePicture = 10,
    MRTopicTypeWord = 29,
    MRTopicTypeVoice = 31,
    MRTopicTypeVideo = 41
} MRTopicType;


@class MRComment;

@interface MRTopic : NSObject

/** 唯一标识 */
@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像的URL */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property (nonatomic, strong) MRComment *top_cmt;
/** 小图片 */
@property (nonatomic, copy) NSString *small_image;
/** 大图片 */
@property (nonatomic, copy) NSString *large_image;
/** 中等图片 */
@property (nonatomic, copy) NSString *middle_image;
/** 帖子类型 */
@property (nonatomic, assign) MRTopicType type;
/** 宽度 */
@property (nonatomic, assign) CGFloat width;
/** 高度 */
@property (nonatomic, assign) CGFloat height;
/** 是否为GIF图片 */
@property (nonatomic, assign) BOOL is_gif;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/**** 辅助属性（为了提高开发效率） ****/
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentFrame;
/** 是否为大图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

/** 这个帖子图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;


@end
