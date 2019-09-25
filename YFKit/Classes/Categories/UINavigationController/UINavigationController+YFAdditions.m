//
//  UINavigationController+Additions.m
//  sqt-ios
//
//  Created by yFeii on 2019/9/20.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "UINavigationController+YFAdditions.h"

@implementation UINavigationController (YFAdditions)
+ (void)load {
    
    swizzled_Method([self class], @selector(pushViewController:animated:), @selector(fi_pushViewController:animated:));
}

// 状态栏颜色
- (UIViewController *)childViewControllerForStatusBarStyle {
    
    return self.viewControllers.lastObject;
}

- (void)fi_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count>=1) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self fi_pushViewController:viewController animated:animated];
}
@end
