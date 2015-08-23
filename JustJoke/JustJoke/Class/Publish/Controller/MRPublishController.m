//
//  MRPublishController.m
//  JustJoke
//
//  Created by Asuna on 15/8/21.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRPublishController.h"

#import "MRPublishButton.h"
#import "MRPostMessageController.h"
#import "MRMainNavController.h"
#import <POP.h>

static const NSInteger  count = 6;
static const CGFloat    TimeDelay = 0.1;
static const NSInteger  SpringBounciness = 10;
static const NSInteger  SpringSpeed = 10;

@interface MRPublishController ()
@property (nonatomic,strong) NSMutableArray *arrayButton;

@property (nonatomic,strong) NSArray *arrayTimes;

@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation MRPublishController

- (NSArray *)arrayTimes
{
    if (!_arrayTimes ) {
        _arrayTimes = @[
                        @(TimeDelay*1),
                        @(TimeDelay*2),
                        @(TimeDelay*3),
                        @(TimeDelay*4),
                        @(TimeDelay*5),
                        @(TimeDelay*6),
                        ];
    }
    
    return _arrayTimes;
}

- (NSMutableArray *)arrayButton
{
    if (_arrayButton == nil) {
        _arrayButton = [NSMutableArray array];
    }
    return _arrayButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = NO;
    
    [self setUp];
    [self setUpAnimationButton];
}

-(void)setUp
{
    self.view.backgroundColor = [UIColor whiteColor];

    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [imageView sizeToFit];
    imageView.center = CGPointMake(Main_Screen_Width*0.5, -Main_Screen_Height);
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.toValue = @(Main_Screen_Height*0.2);
    animation.beginTime = CACurrentMediaTime() + [[self.arrayTimes lastObject] floatValue];
    animation.springSpeed = SpringSpeed;
    animation.springBounciness = SpringBounciness;
    [animation setCompletionBlock:^(POPAnimation *ani, BOOL done) {
        self.view.userInteractionEnabled = YES;
    }];
    [imageView.layer pop_addAnimation:animation forKey:nil];

    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"shareButtonCancel"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"shareButtonCancelClick"] forState:UIControlStateHighlighted];
    [cancelButton sizeToFit];
    cancelButton.center = CGPointMake(Main_Screen_Width*0.5, Main_Screen_Height*0.9);
    [cancelButton addTarget:self action:@selector(clickToBack) forControlEvents:UIControlEventTouchUpInside];
    //[cancelButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside]
    [self.view addSubview:cancelButton];
}

-(void)setUpAnimationButton
{
    NSArray *arrayTitle = @[@"发视频",
                            @"发图片",
                            @"发段子",
                            @"发声音",
                            @"审帖",
                            @"离线下载"];
    
    NSArray *arrayImage = @[@"publish-video",
                            @"publish-picture",
                            @"publish-text",
                            @"publish-audio",
                            @"publish-review",
                            @"publish-offline"];
    
    CGFloat buttonWidth = Main_Screen_Width/3.0;
    CGFloat buttonHeight = Main_Screen_Width/3.0;
    
    for (NSInteger i = 0;  i < count; i++) {
        
        MRPublishButton *button = [MRPublishButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:arrayTitle[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:arrayImage[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake(i%3*buttonWidth,2*Main_Screen_Height,buttonWidth, buttonHeight);
        [button addTarget:self action:@selector(clickTodo:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.view addSubview:button];
 
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(i%3*buttonWidth, (Main_Screen_Height - 2*buttonHeight)*0.7 + i/3*buttonHeight,buttonWidth, buttonHeight)];
        animation.beginTime = CACurrentMediaTime() + [self.arrayTimes[i] floatValue];
        animation.springSpeed = SpringSpeed;
        animation.springBounciness = SpringBounciness;
        
        [button pop_addAnimation:animation forKey:nil];
        [self.arrayButton addObject:button];
    }
}

-(void)clickTodo:(MRPublishButton*)sender
{
    [self buttonBack:^{
        if (sender.tag == 2) {
            MRPostMessageController *post = [[MRPostMessageController alloc]init];
            MRMainNavController *nav = [[MRMainNavController alloc]initWithRootViewController:post];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
        }
        
    }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self buttonBack:nil];
}

-(void)clickToBack
{
    [self buttonBack:nil];
}

-(void)buttonBack:(void(^)())task
{

    for (NSInteger i = 0;  i < count; i++) {
        MRPublishButton *button = self.arrayButton[i];
        POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(button.x,  2*Main_Screen_Height,button.width, button.height)];
        animation.beginTime = CACurrentMediaTime() + [self.arrayTimes[i] floatValue];
        [button pop_addAnimation:animation forKey:nil];
    }

    POPBasicAnimation *animationImage = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animationImage.toValue = @(-Main_Screen_Height);
    animationImage.beginTime = CACurrentMediaTime() + [[self.arrayTimes lastObject] floatValue];
    [animationImage setCompletionBlock:^(POPAnimation * animation, BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
        !task ? : task();
    }];
    [self.imageView.layer pop_addAnimation:animationImage forKey:nil];

}

@end
