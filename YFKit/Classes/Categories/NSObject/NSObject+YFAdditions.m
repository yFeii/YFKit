//
//  NSObject+YFAdditions.m
//  AFNetworking
//
//  Created by yFeii on 2020/1/13.
//

#import "NSObject+YFAdditions.h"


@implementation NSObject (YFAdditions)

+ (void)setTabbarSelectedIndex:(NSUInteger)index{
    
    UITabBarController *tbc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if (index >= tbc.childViewControllers.count || index < 0) return;
    UIViewController *topVC = [UIViewController getCurrentVC];
    while (topVC.presentingViewController) {
        topVC = topVC.presentingViewController;
    }
    if (topVC.presentedViewController) {
        [topVC dismissViewControllerAnimated:false completion:^{
            UIViewController *currentC = [UIViewController getCurrentVC];
            [currentC.navigationController popToRootViewControllerAnimated:false];
            [tbc setSelectedIndex:index];
        }];
    }else{
        [topVC.navigationController popToRootViewControllerAnimated:false];
        [tbc setSelectedIndex:index];
    }
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC {
    
    UIViewController *result = nil;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    do {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navi = (UINavigationController *)rootVC;
            UIViewController *vc = [navi.viewControllers lastObject];
            result = vc;
            rootVC = vc.presentedViewController;
            continue;
        } else if([rootVC isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)rootVC;
            result = tab;
            rootVC = [tab.viewControllers objectAtIndex:tab.selectedIndex];
            continue;
        } else if([rootVC isKindOfClass:[UIViewController class]]) {
            result = rootVC;
            rootVC = nil;
        }
    } while (rootVC != nil);
    
    return result;
}
@end
