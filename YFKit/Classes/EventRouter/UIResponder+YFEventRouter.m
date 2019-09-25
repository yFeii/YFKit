//
//  UIResponder+Router.m
//  sqt-ios
//
//  Created by yFeii on 2019/7/2.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "UIResponder+YFEventRouter.h"

@implementation UIResponder (YFEventRouter)
- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if (self.nextResponder) {
        [[self nextResponder] routerWithEventName:eventName userInfo:userInfo];
    }
}



@end
