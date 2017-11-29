//
//  ViewController.m
//  MakemojiSDKDemo
//
//  Created by WhatsXie on 2017/11/29.
//  Copyright © 2017年 R.S. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewToBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *textChatView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textChatView.layer.cornerRadius = 10.0;
    
    self.meTextInputView = [[METextInputView alloc] initWithFrame:CGRectZero];
    self.meTextInputView.delegate = self;
    [self.meTextInputView detachTextInputView:YES];
    [self.view addSubview:_meTextInputView];
    
    self.meTextInputView.textInputContainerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 320);
    [self.textChatView addSubview:_meTextInputView.textInputContainerView];
    
    
    //监听当键盘将要出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    float height = keyboardRect.size.height;
    self.textViewToBottomConstraint.constant = height - 80;
    
    [UIView animateWithDuration:0.37 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification {
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    float height = keyboardRect.size.height;
    self.textViewToBottomConstraint.constant = 0;
    
    [UIView animateWithDuration:0.37 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
