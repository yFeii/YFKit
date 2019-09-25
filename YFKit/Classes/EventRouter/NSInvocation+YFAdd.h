//
//  NSInvocation+YFAdd.h
//  sqt-ios
//
//  Created by yFeii on 2019/7/18.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSInvocation (YFAdd)

- (void)safeSetArgument:(void *)argumentLocation atIndex:(NSInteger)idx;
@end

NS_ASSUME_NONNULL_END
