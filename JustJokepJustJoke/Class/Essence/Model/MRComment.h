//
//  MRComment.h
//  JustJoke
//
//  Created by Asuna on 15/9/7.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MRUser;

@interface MRComment : NSObject


/** ID */
@property (nonatomic, strong) NSString *ID;
/** 文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) MRUser *user;
/** 音频时间 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;


@end
