//
//  UITableVeiw+Fitter.m
//  HGOrderingMerchant
//
//  Created by ShiGY on 2017/10/26.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import "UITableView+YFAdditions.h"
#import "objc/runtime.h"

@implementation UITableView (YFAdditions)

+(void)load {
    
    swizzled_Method([self class], @selector(init), @selector(afterInit));
    swizzled_Method([self class], @selector(initWithFrame:style:), @selector(after_initWithFrame:style:));

}

- (instancetype)afterInit {
    
    UITableView *temp = [self afterInit];
    if (temp) {
        
        temp.estimatedRowHeight = 0.0;
        temp.estimatedSectionFooterHeight = 0.0;
        temp.estimatedSectionHeaderHeight = 0.0;
        if (@available(iOS 11.0,*)) {
            temp.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return temp;
}

- (instancetype)after_initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    UITableView *temp = [self after_initWithFrame:frame style:style];
    if (temp) {
        temp.estimatedRowHeight = 0.0;
        temp.estimatedSectionFooterHeight = 0.0;
        temp.estimatedSectionHeaderHeight = 0.0;
        if (@available(iOS 11.0,*)) {
            temp.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return temp;

}
@end
