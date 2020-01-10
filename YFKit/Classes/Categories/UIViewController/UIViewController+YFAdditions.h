//
//  UIViewController+navConfig.h
//  360FI
//
//  Created by Jiansi on 2018/8/18.
//  Copyright © 2018年 Calvien. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (YFAdditions)

- (void)setTabbarSelectedIndex:(NSUInteger)index;
- (UIViewController *)getCurrentVC;
@end


@interface UIViewController (YFNavConfig)

- (void)goBackWithAnimation:(BOOL)animation;

//自定义返回按钮图片，颜色
- (void)setBackBtn:(NSString *)imageName tintColor:(UIColor *)tintColor;

//默认返回按钮 箭头 黑色
- (void)setupDefalutBack;
//设置默认返回按钮颜色
- (void)setupDefalutBackTintColor:(UIColor *)tintColor;;

//延迟返回：用于拿到成功结果之后返回
- (void)setDelayBack:(NSTimeInterval)time;

- (void)presentVC:(UIViewController *)vc needNav:(BOOL)isNeed animated:(BOOL)flag completion:(void (^)(void))completion;

- (void)presentVC:(UIViewController *)vc animated:(BOOL)flag completion:(void (^)(void))completion;


@end
