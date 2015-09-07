//
//  MRTopic.m
//  JustJoke
//
//  Created by Asuna on 15/9/5.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRTopic.h"
#import "MRUser.h"

#import "MRComment.h"
@implementation MRTopic


+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             @"small_image" : @"image0",
             @"middle_image" : @"image2",
             @"large_image" : @"image1",
             @"top_cmt" : @"top_cmt[0]"
             };
}


- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        // 顶部的头像
        _cellHeight = MRTopicProfileImageMaxY + Margin;
        
        // 文字
        CGSize maxTextSize = CGSizeMake(Main_Screen_Width - 2 * Margin, MAXFLOAT);
        _cellHeight += [self.text boundingRectWithSize:maxTextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : MRTopicTextFont} context:nil].size.height + Margin;
        
        // 中间内容
        if (self.type != MRTopicTypeWord) { // 中间有内容
            CGFloat contentX = Margin;
            CGFloat contentY = _cellHeight;
            CGFloat contentW = maxTextSize.width;
            CGFloat contentH = contentW * self.height / self.width;
            // 如果图片帖子的内容高度过高，那么就限制一下
            if (self.type == MRTopicTypePicture && contentH > Main_Screen_Height) {
                contentH = 200;
                
                // 大图片
                self.bigPicture = YES;
            }
            self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
            
            _cellHeight += contentH + Margin;
        }
        
        // 最热评论
        if (self.top_cmt) {
            
            NSString *commentText = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
            _cellHeight += MRTopicTopCmtTitleH + [commentText boundingRectWithSize:maxTextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : MRTopicTextFont} context:nil].size.height + Margin;
        }
        
        // 工具条
        _cellHeight += MRTopicToolbarH + Margin;
    }
    return _cellHeight;
}


- (NSString *)create_time
{
    // 创建1次formatter
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    
    // 获得日期对象
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [formatter dateFromString:_create_time];
    
    // 获得createDate和当前时间的差值
    NSDateComponents *cmps = createDate.intervalToNow;
    
    // 根据日期对象返回对应的时间字符串
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            if (cmps.hour >= 1) { // interval >= 1小时  xx小时前
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > interval >= 1分钟  xx分钟前
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > interval  刚刚
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天 HH:mm:ss
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:createDate];
        } else { // MM-dd HH:mm:ss
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:createDate];
        }
    } else { // yyyy-MM-dd HH:mm:ss
        return _create_time;
    }
}
@end
