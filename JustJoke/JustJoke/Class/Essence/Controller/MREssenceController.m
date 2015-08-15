//
//  MREssenceController.m
//  JustJoke
//
//  Created by Asuna on 15/8/15.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MREssenceController.h"

@interface MREssenceController ()

@end

@implementation MREssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MRGlobalBackgroundColor;
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
   self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftBarButtonClick) image:@"MainTagSubIcon" highLightImage:@"MainTagSubIconClick"];  // Do any additional setup after loading the view.
}

-(void)leftBarButtonClick
{
    MRLogFunc;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
