//
//  UIButton+YFAdditional.h
//  sqt-ios
//
//  Created by yFeii on 2019/7/10.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};


@interface UIButton (YFAdditional)

- (void)setGradulColors:(NSArray *)color forState:(UIControlState)state;

@end

@interface UIButton (ImageTitleSpacing)

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end

@interface UIButton (YFFactory)
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor normalImage:(NSString *)normalImage highlightImage:(NSString *)highlightImage;
+ (UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor bgImage:(NSString *)bgImage;

@end


NS_ASSUME_NONNULL_END
