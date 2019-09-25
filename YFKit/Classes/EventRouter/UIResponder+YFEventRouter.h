//
//  UIResponder+Router.h
//  sqt-ios
//
//  Created by yFeii on 2019/7/2.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN



@interface UIResponder (YFEventRouter)
- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
