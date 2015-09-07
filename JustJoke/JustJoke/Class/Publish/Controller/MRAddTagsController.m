//
//  MRAddTagsController.m
//  JustJoke
//
//  Created by Asuna on 15/8/23.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRAddTagsController.h"
#import "MRTagTextField.h"
#import "MRTagButton.h"
#import <SVProgressHUD.h>
@interface MRAddTagsController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) MRTagTextField *textField;
@property (nonatomic, weak) UIButton *addTagButton;
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation MRAddTagsController

#pragma mark - 懒加载
- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (UIButton *)addTagButton
{
    if (!_addTagButton) {
        UIButton *addTagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addTagButton addTarget:self action:@selector(addTag) forControlEvents:UIControlEventTouchUpInside];
        addTagButton.backgroundColor = MRTagBackgroundColor;
        addTagButton.width = self.contentView.width;
        addTagButton.height = MRTagHeight;
        addTagButton.titleLabel.font = [UIFont systemFontOfSize:15];
        addTagButton.contentEdgeInsets = UIEdgeInsetsMake(0, SmallMargin, 0, SmallMargin);
        // 让按钮里面的内容左对齐
        addTagButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [addTagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:addTagButton];
        _addTagButton = addTagButton;
    }
    return _addTagButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupcontentView];
    [self setupTextField];
}
//**************************************setupNav********************************************
- (void)setupNav
{
    self.title = @"添加标签";
   // self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)done
{
    // 获得所有的标签数据
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    
    // 使用block传递标签数据回到上一个控制器
    if (self.getTagsBlock) {
        self.getTagsBlock(tags);
    }    
    // 关闭
    [self dismissViewControllerAnimated:YES completion:nil];
}
//**************************setupcontentView******************************************
-(void)setupcontentView
{
    UIView *contentView = [[UIView alloc]init];
    contentView.frame = CGRectMake(SmallMargin , kTopBarHeight + kStatusBarHeight + SmallMargin, Main_Screen_Width - 2*SmallMargin, Main_Screen_Height - 2*SmallMargin);
    //contentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}
//*************************setupTextField***********************************************

-(void)setupTextField
{
    WEAKSELF;
    
    MRTagTextField *textField = [[MRTagTextField alloc] init];
    textField.width = self.contentView.width;
    textField.height = MRTagHeight;
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    textField.delegate = self;
    [textField setBeforeDeleteBackwardBlock:^{
        if (weakSelf.textField.hasText) return;
        
        // 删除最后一个标签按钮
        MRTagButton *lastTagButton = weakSelf.tagButtons.lastObject;
        [self deleteTag:lastTagButton];
    }];
    [textField becomeFirstResponder];
    [textField layoutIfNeeded]; // 强制刷新
    [self.contentView addSubview:textField];
    self.textField = textField;
}

- (void)setupTagButtons
{
    for (NSString *tag in self.arrayTags) {
        self.textField.text = tag;
        [self addTag];
    }
}

/**
 *  监听textField文字的改变
 */
- (void)textDidChange
{
    if (self.textField.hasText) {
        // 计算文本框的frame
        [self setupTextFieldFrame];
        
        // "添加标签按钮"的设置
        self.addTagButton.hidden = NO;
        [self.addTagButton setTitle:[NSString stringWithFormat:@"添加标签：%@", self.textField.text] forState:UIControlStateNormal];
        
        // 查看输入的最后一个文字
        NSString *text = self.textField.text;
        if (text.length == 1) return;
        
        // unichar是多字节字符，char是单字节字符
        // unichar的占位符是%C，char的占位符是%c
        unichar lastChar = [text characterAtIndex:text.length - 1];
        NSString *lastString = [NSString stringWithFormat:@"%C", lastChar];
        if ([lastString isEqualToString:@","] || [lastString isEqualToString:@"，"]) {
            // 去掉最后一个逗号(, ，)
            [self.textField deleteBackward];
            
            // 添加一个标签
            [self addTag];
        }
    } else {
        self.addTagButton.hidden = YES;
    }
}


/**
 *  监听添加标签按钮
 */
- (void)addTag
{
    // 如果没有文字，就不添加标签
    if (self.textField.hasText == NO) return;
    
    // 最多添加5个标签
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    // 添加一个标签按钮
    MRTagButton *tagButton = [[MRTagButton alloc] init];
    [tagButton addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [self.contentView addSubview:tagButton];
    
    // 计算标签按钮的位置
    MRTagButton *lastTagButton = [self.tagButtons lastObject];
    if (lastTagButton) {
        // 这一行右边剩下的宽度
        CGFloat rightWidth = self.contentView.width - CGRectGetMaxX(lastTagButton.frame) - SmallMargin;
        if (rightWidth >= tagButton.width) {
            tagButton.y = lastTagButton.y;
            tagButton.x = CGRectGetMaxX(lastTagButton.frame) + SmallMargin;
        } else {
            tagButton.x = 0;
            tagButton.y = CGRectGetMaxY(lastTagButton.frame) + SmallMargin;
        }
    }
    
    // 存放标签按钮
    [self.tagButtons addObject:tagButton];
    
    // 清空文本框的文字
    self.textField.text = nil;
    
    // 计算文本框的frame
    [self setupTextFieldFrame];
    
    // 隐藏“添加标签”按钮
    self.addTagButton.hidden = YES;
}

/**
 * 监听标签按钮点击：删除标签
 */
- (void)deleteTag:(MRTagButton *)deletedTagButton
{
    [UIView beginAnimations:nil context:nil];
    
    // 获得被删除的按钮的位置
    NSUInteger index = [self.tagButtons indexOfObject:deletedTagButton];
    
    // 删除按钮
    [deletedTagButton removeFromSuperview];
    [self.tagButtons removeObject:deletedTagButton];
    
    // 重新排布所有标签按钮
    for (NSUInteger i = index; i < self.tagButtons.count; i++) {
        MRTagButton *tagButton = self.tagButtons[i];
        if (i > 0) {
            MRTagButton *previousTagButton = self.tagButtons[i - 1];
            // 这一行右边剩下的宽度
            CGFloat rightWidth = self.contentView.width - CGRectGetMaxX(previousTagButton.frame) - SmallMargin;
            if (rightWidth >= tagButton.width) {
                tagButton.y = previousTagButton.y;
                tagButton.x = CGRectGetMaxX(previousTagButton.frame) + SmallMargin;
            } else {
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(previousTagButton.frame) + SmallMargin;
            }
        } else {
            tagButton.x = 0;
            tagButton.y = 0;
        }
    }
    
    // 重新排布文本框
    [self setupTextFieldFrame];
    
    [UIView commitAnimations];
}

#pragma mark - 计算frame
/**
 *  计算文本框的frame
 */
- (void)setupTextFieldFrame
{
    // 最后一个标签按钮
    MRTagButton *tagButton = self.tagButtons.lastObject;
    
    // 计算文字的宽度
    CGFloat textFieldWidth = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    textFieldWidth = MAX(100, textFieldWidth);
    
    // 右边剩下的宽度
    CGFloat rightWidth = self.contentView.width - CGRectGetMaxX(tagButton.frame) - SmallMargin;
    if (rightWidth >= textFieldWidth) {
        self.textField.y = tagButton.y;
        self.textField.x = CGRectGetMaxX(tagButton.frame) + SmallMargin;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(tagButton.frame) + SmallMargin;
    }
    
    // 文本框底部“添加标签”按钮的位置
    self.addTagButton.y = CGRectGetMaxY(self.textField.frame) + SmallMargin;
}


#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addTag];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 退出键盘
    [self.textField resignFirstResponder];
}

#pragma mark - 监听
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
