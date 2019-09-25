//
//  UILabel+YFAdditional.h
//  sqt-ios
//
//  Created by yFeii on 2019/7/10.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (YFAdditions)

@end

@interface UILabel (YFFactory)

+ (UILabel *)labelWithFont:(CGFloat)font textColor:(UIColor *)textColor;
+ (UILabel *)labelWithFont:(CGFloat)font textColor:(UIColor *)textColor text:(NSString *)text;
+ (UILabel *)labelWithFont:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;
+ (UILabel *)labelWithFont:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text;
+ (UILabel *)labelWithFontName:(NSString *)font fontSize:(CGFloat)size textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text;
+ (UILabel *)labelWithUserFont:(UIFont *)userFont textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text;
@end


@interface UILabel (YFRect)


/**
 根据内容计算label尺寸
 
 @param text 内容
 @param fontSize 字体尺寸
 @param maxSize 设定尺寸
 @return 尺寸
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

+ (CGSize)labelAutoCalculateRectWith:(NSString*)text LineSpace:(CGFloat)lineSpace FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

+ (CGSize)labelAutoCalculateRectWith:(NSString*)text fontName:(NSString *)fontName LineSpace:(CGFloat)lineSpace FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

- (NSArray *)getSeparatedLinesFromLabel;

@end

NS_ASSUME_NONNULL_END
