//
//  NSInvocation+YFAdd.m
//  sqt-ios
//
//  Created by yFeii on 2019/7/18.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "NSInvocation+YFAdd.h"

@implementation NSInvocation (YFAdd)

- (void)safeSetArgument:(void *)argumentLocation atIndex:(NSInteger)idx {
    
    if (self.methodSignature.numberOfArguments>idx) {
        
        [self setArgument:argumentLocation atIndex:idx];
    }else{
        NSLog(@"Argument at index %ld beyond bounds %ld", idx, self.methodSignature.numberOfArguments);
    }
}
@end
