//
//  MRCommentHeader.m
//  JustJoke
//
//  Created by Asuna on 15/9/7.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRCommentHeader.h"


@interface MRCommentHeader()
/** 文字 */
@property (nonatomic, weak) UILabel *label;
@end

@implementation MRCommentHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = MRTagBackgroundColor;
        
        // label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RgbColor(70, 70, 70);
        label.font = [UIFont systemFontOfSize:14];
        label.x = SmallMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    self.label.text = text;
}

@end
