//
//  ViewController.h
//  MakemojiSDKDemo
//
//  Created by WhatsXie on 2017/11/29.
//  Copyright © 2017年 R.S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "METextInputView.h"

@interface ViewController : UIViewController <METextInputViewDelegate>
@property (nonatomic, retain) METextInputView * meTextInputView;
@end

