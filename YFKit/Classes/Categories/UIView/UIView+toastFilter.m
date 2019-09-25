//
//  UIView+toastFilter.m
//  HGOrderingMerchant
//
//  Created by ShiGY on 2017/10/24.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import "UIView+toastFilter.h"
#import "objc/runtime.h"
#import "UIView+Toast.h"

@implementation UIView (toastFilter)

+(void)load{
    
    swizzled_Method([self class], @selector(toastViewForMessage:title:image:style:), @selector(filter_toastViewForMessage:title:image:style:));
}

- (UIView *)filter_toastViewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image style:(CSToastStyle *)style{
    
    if (message.length<=0 && title.length<=0) {
        return nil;
    }
    return [self filter_toastViewForMessage:message title:title image:image style:style];
}
- (void)filter_makeToast:(NSString *)message duration:(float)duration position:(id)position{
    
    if (self.toastViewIsVisible) return;
    self.toastViewIsVisible = YES;
    WS(wSelf);
    [self makeToast:message duration:duration position:position title:nil image:nil style:nil completion:^(BOOL didTap) {
        
        if (!wSelf) return;
        wSelf.toastViewIsVisible = NO;
    }];
}

- (void)setToastViewIsVisible:(BOOL)toastViewIsVisible {
    
    objc_setAssociatedObject(self, @selector(toastViewIsVisible), @(toastViewIsVisible), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)toastViewIsVisible {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
@end
