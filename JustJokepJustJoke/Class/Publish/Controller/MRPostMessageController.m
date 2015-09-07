//
//  MRPostMessageController.m
//  JustJoke
//
//  Created by Asuna on 15/8/21.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRPostMessageController.h"

#import "MRPlaceholderTextView.h"

#import "MRPostKeyBoardHeaderView.h"

@interface MRPostMessageController ()<UITextViewDelegate>
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UITextView *textView;

@property (nonatomic,strong) MRPostKeyBoardHeaderView  *keyBoardHeaderView;

@end

@implementation MRPostMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupContentView];
    [self setupTextView];
    [self setupInputView];
    // Do any additional setup after loading the view.
}

//************************************************************************************
- (void)setupNav
{
    self.title = @"发表文字";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    // 强制更新
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
   
}
//************************************************************************************
-(void)setupContentView
{
    UIView *contentView = [[UIView alloc]init];
    contentView.frame = CGRectMake(SmallMargin , kTopBarHeight + kStatusBarHeight + SmallMargin, Main_Screen_Width - 2*SmallMargin, Main_Screen_Height - 2*SmallMargin);
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

//************************************************************************************
-(void)setupTextView
{
    MRPlaceholderTextView *textView = [[MRPlaceholderTextView alloc]init];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.placeholderColor = [UIColor grayColor];
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.frame = self.contentView.bounds;
    textView.delegate = self;
    
    //用来自定义键盘
    //textView.inputView
    //textView.inputAccessoryView =
    textView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:textView];
    
    self.textView = textView;
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

//************************************************************************
-(void)setupInputView{
    MRPostKeyBoardHeaderView *keyBoardView = [MRPostKeyBoardHeaderView viewFromNib];
    //keyBoardView.width = self.view.width;
    keyBoardView.y = self.view.height - keyBoardView.height;
    keyBoardView.width = self.view.width;
   // keyBoardView.x = 0;
    [self.view addSubview:keyBoardView];
    self.keyBoardHeaderView = keyBoardView;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)keyboardChange:(NSNotification*)note
{
    NSLog(@"%@",note);
    // 动画时间
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        CGFloat ty = keyboardY - Main_Screen_Height;
        self.keyBoardHeaderView.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
}
//*************************************************************************
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
}
@end
