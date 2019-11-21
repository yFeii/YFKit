//
//  YFResponseConcentrateHandler.h
//  sqt-ios
//
//  Created by yFeii on 2019/8/7.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFResponseConcentrateHandler : NSObject

@property (nonatomic, strong) YFBaseRequest *baseRequest;
+ (instancetype)shareInstance;

//业务是否成功，需要在 category 重写，
- (BOOL)businessIsSuccess:(YFBaseRequest *)request;

//响应结果的统一处理。默认不处理，如需处理可通过category override
- (BOOL)handleEventWithResponse:(YFBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
