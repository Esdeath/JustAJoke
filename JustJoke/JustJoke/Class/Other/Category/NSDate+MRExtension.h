//
//  NSDate+MRExtension.h
//  JustJoke
//
//  Created by Asuna on 15/9/5.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MRExtension)
/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为明天
 */
- (BOOL)isTomorrow;

/**
 *  获得跟当前时间（now）的差值
 */
- (NSDateComponents *)intervalToNow;
@end
