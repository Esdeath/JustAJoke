//
//  MRRecommend.h
//  JustJoke
//
//  Created by Asuna on 15/8/16.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MRRecommend : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, strong) NSNumber*  sub_number;


@end
