//
//  YFResponseConcentrateHandler.m
//  sqt-ios
//
//  Created by yFeii on 2019/8/7.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "YFResponseConcentrateHandler.h"

@implementation YFResponseConcentrateHandler

+ (instancetype)shareInstance {
    
    static YFResponseConcentrateHandler *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YFResponseConcentrateHandler alloc] init];
        
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (BOOL)businessIsSuccess:(YFBaseRequest *)request {
    
    return YES;
}

- (BOOL)handleEventWithResponse:(YFBaseRequest *)request {
    
    return YES;
}
@end
