//
//  MRLoginRegisterViewController.m
//  JustJoke
//
//  Created by Asuna on 15/8/17.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRLoginRegisterViewController.h"

@interface MRLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLoginCon;

@end

@implementation MRLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickLogout:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerAndLogin:(UIButton *)sender {
    
    if (self.leftLoginCon.constant == 0) {
        sender.selected = NO;
        self.leftLoginCon.constant = -Main_Screen_Width;
    } else {
        self.leftLoginCon.constant = 0;
        sender.selected = YES;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
