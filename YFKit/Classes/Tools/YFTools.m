//
//  XHTools.m
//  sqt-ios
//
//  Created by yFeii on 2019/7/1.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "YFTools.h"
#import "objc/runtime.h"

void swizzled_Method(Class class, SEL originalSelector, SEL swizzledSelector){
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success)
    {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
void swizzled_ClassMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    Class metaClass = objc_getMetaClass(class_getName(class));
    BOOL success = class_replaceMethod(metaClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success)
    {
        class_replaceMethod(metaClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
    }
}




@interface YFTools()

@property (nonatomic, assign) CGFloat cacheStatusBarHeight;
@property (nonatomic, assign) CGFloat cacheNavBarHeight;
@property (nonatomic, assign) CGFloat cacheScreenWidth;
@property (nonatomic, assign) CGFloat cacheScreenHeight;
@property (nonatomic, assign) CGFloat cacheTabbarHeight;


@end

@implementation YFTools

+ (YFTools *)tool {
    
    static YFTools *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YFTools alloc] init];
        manager.cacheStatusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        UINavigationController *temp = [[UINavigationController alloc] init];
        manager.cacheNavBarHeight = temp.navigationBar.frame.size.height;
        manager.cacheScreenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        manager.cacheScreenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    });
    return manager;
}

- (CGFloat)statusBarHeight {
    
    return self.cacheStatusBarHeight;
}

- (CGFloat)navigationBarHeight {
    
    return self.cacheNavBarHeight;
}

- (CGFloat)screenWidth {
    
    return self.cacheScreenWidth;
}

- (CGFloat)screenHeight {
    
    return self.cacheScreenHeight;
}

- (CGFloat)tabbarHeight {
    
    return self.cacheTabbarHeight;
}

- (CGFloat)navigationHeight {
    return self.cacheNavBarHeight+self.cacheStatusBarHeight;
}
- (void)updateTabBarHeight:(CGFloat)height {
    
    self.cacheTabbarHeight = height;
}

#pragma mark - isStringEmpty
+ (BOOL)isStringEmpty:(NSString *)targetString {
    
    if (![targetString isKindOfClass:[NSString class]]) {
        targetString = targetString.description;
    }
    if ([targetString isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([targetString isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([targetString isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([targetString isEqualToString:@"(null)(null)"]) {
        return YES;
    }
    if ([[targetString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

@end

