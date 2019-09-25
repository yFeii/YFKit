//
//  UIColor+HGUI.h
//  HGOrdering
//
//  Created by Tianbiao Wang on 17/7/11.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YFAdditions)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;
@end
