//
//  XHTools.h
//  sqt-ios
//
//  Created by yFeii on 2019/7/1.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

extern void swizzled_Method(Class class, SEL originalSelector, SEL swizzledSelector);

extern void swizzled_ClassMethod(Class class, SEL originalSelector, SEL swizzledSelector);

@interface YFTools : NSObject
+ (YFTools *)tool;

+ (BOOL)isStringEmpty:(NSString *)targetString;


- (CGFloat)statusBarHeight;
- (CGFloat)navigationBarHeight;
- (CGFloat)screenWidth;
- (CGFloat)screenHeight;
- (CGFloat)tabbarHeight;
- (CGFloat)navigationHeight;
- (void)updateTabBarHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
