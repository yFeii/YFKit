//
//  NSObject+YFInvocation.h
//  sqt-ios
//
//  Created by yFeii on 2019/7/17.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YFInvocation)

- (NSInvocation *)createInvocationWithInstanceSelector:(SEL)selector;
+ (NSInvocation *)createInvocationWithClassSelector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
