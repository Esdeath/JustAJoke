//
//  MRShowPictureViewController.m
//  JustJoke
//
//  Created by Asuna on 15/9/4.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRShowPictureViewController.h"
#import "MRTopic.h"
@interface MRShowPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation MRShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 计算图片的frame
    imageView.x = 0;
    imageView.width = Main_Screen_Width;
    imageView.height = imageView.width * self.topic.height / self.topic.width;
    if (imageView.height > Main_Screen_Height) { // 图片高度 超过 屏幕高度
        imageView.y = 0;
        
        // 设置内容大小
        scrollView.contentSize = CGSizeMake(0, imageView.height);
    } else {
        imageView.y = (Main_Screen_Height - imageView.height) * 0.5;
    }
    
    // 设置缩放比例
    CGFloat scale = self.topic.width / imageView.width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    // 保存图片的回调方法必须有3个参数，方法名可以自定义
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//- (void)abc:(UIImage *)image abc:(NSError *)error abc:(void *)contextInfo
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
