//
//  NSObject+YFInvocation.m
//  sqt-ios
//
//  Created by yFeii on 2019/7/17.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "NSObject+YFInvocation.h"
#import "objc/runtime.h"

@implementation NSObject (YFInvocation)

- (NSInvocation *)createInvocationWithInstanceSelector:(SEL)selector{
    
    NSMethodSignature *sign = [[self class] instanceMethodSignatureForSelector:selector];
    if (sign) {
    
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sign];
        [inv setTarget:self];
        [inv setSelector:selector];
        return inv;
    }
    return nil;
}
+ (NSInvocation *)createInvocationWithClassSelector:(SEL)selector{
    
    Class meteClass = objc_getMetaClass(class_getName([self class]));
    NSMethodSignature *sign = [meteClass instanceMethodSignatureForSelector:selector];
    if (sign) {
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sign];
        [inv setTarget:[self class]];
        [inv setSelector:selector];
        return inv;
    }
    return nil;
}

@end
