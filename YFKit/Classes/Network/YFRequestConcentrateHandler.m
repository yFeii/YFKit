//
//  YFRequestConcentrateHandler.m
//  sqt-ios
//
//  Created by yFeii on 2019/8/7.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "YFRequestConcentrateHandler.h"

@implementation YFRequestConcentrateHandler

+ (instancetype)shareInstance {
    
    static YFRequestConcentrateHandler *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YFRequestConcentrateHandler alloc] init];
        
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}


- (BOOL)handleEventWithRequest:(YFBaseRequest *)request {
    
    return YES;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    
    return params;
}
@end
