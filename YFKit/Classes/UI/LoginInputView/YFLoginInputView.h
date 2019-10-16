//
//  HGLoginInputView.h
//  HGOrderingMerchant
//
//  Created by GY on 2017/8/30.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+YFAdditions.h"

typedef NS_ENUM(NSUInteger, YFLoginInputViewType) {
    YFLoginInputViewTypeSecret,
    YFLoginInputViewTypeVerify,
    YFLoginInputViewTypeDefault,
};

@interface YFLoginInputView : UIView


- (instancetype)initWithType:(YFLoginInputViewType)type;

@property (nonatomic, assign) YFLoginInputViewType type;

@property (nonatomic, strong) UILabel *lineLab;

@property (nonatomic, copy) void(^textFieldChangedCallBack)(NSString *text);

@property (nonatomic, copy) void(^clickSendVerifyCodeCallBack)(void);

@property (nonatomic, copy) NSAttributedString *placeholder;
@property (nonatomic, assign)float leftMargin;
@property (nonatomic, assign)UIEdgeInsets contentEdgeInets;
@property (nonatomic, strong) UITextField *inputTextField;


- (void)setEdit:(BOOL)isEdit;
- (void)setText:(NSString *)text;
- (NSString *)text;

// 设置监听，要在设置输入最大长度后调用
- (void)setup;

- (void)startTime;
@end
