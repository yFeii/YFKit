//
//  NSError+YFAdd.m
//  sqt-ios
//
//  Created by yFeii on 2019/7/26.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "NSError+YFAdd.h"
#import "objc/runtime.h"

@implementation NSError (YFAdd)
- (void)setErrorMsg:(NSString *)errorMsg {
    
    objc_setAssociatedObject(self, @selector(errorMsg), errorMsg, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)errorMsg {
    
    return objc_getAssociatedObject(self, _cmd);
}
@end
