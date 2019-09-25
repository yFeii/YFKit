//
//  FIBaseAlertView.h
//  360FI
//
//  Created by Jiansi on 2018/8/25.
//  Copyright © 2018年 Calvien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFBaseAlertView : UIView

@property (nonatomic, strong) UIView *contentBackView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *backView;         //渐变背景色

- (void)show:(BOOL)isShow;

@end
