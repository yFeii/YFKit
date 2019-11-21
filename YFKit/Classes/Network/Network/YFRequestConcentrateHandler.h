//
//  YFRequestConcentrateHandler.h
//  sqt-ios
//
//  Created by yFeii on 2019/8/7.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFRequestConcentrateHandler : NSObject

@property (nonatomic, strong) YFBaseRequest *baseRequest;
+ (instancetype)shareInstance;

//参数的统一处理。默认不处理，如需处理可通过category override
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (BOOL)handleEventWithRequest:(YFBaseRequest *)request;
@end

NS_ASSUME_NONNULL_END
