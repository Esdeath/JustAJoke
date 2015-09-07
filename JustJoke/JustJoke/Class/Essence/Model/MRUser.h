//
//  MRUser.h
//  JustJoke
//
//  Created by Asuna on 15/9/5.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别【f:女（female），m:男（male）】 */
@property (nonatomic, copy) NSString *sex;

@end
