//
//  MRRecommendCell.m
//  JustJoke
//
//  Created by Asuna on 15/8/16.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRRecommendCell.h"
#import "MRRecommend.h"
#import "UIImage+MRImage.h"
#import <UIKit/UIKit.h>
@interface MRRecommendCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLable;
@property (weak, nonatomic) IBOutlet UILabel *subNumber;

@end

@implementation MRRecommendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommand:(MRRecommend *)recommand
{
    _recommand = recommand;
    
    [self.imageListView setHeader:recommand.image_list placeHold:@"defaultUserIcon"];
    self.themeNameLable.text = recommand.theme_name;
    
    NSString *str = nil;
    if ([recommand.sub_number integerValue]  >= 10000) {
        str = [NSString stringWithFormat:@"%.1f万",recommand.sub_number.floatValue/10000.0];
    } else {
        str = recommand.sub_number.stringValue;
    }
    
    self.subNumber.text = str;
}

- (void)setFrame:(CGRect)frame
{
    
    frame.size.height -= 1;
   [super setFrame:frame];
}

@end
