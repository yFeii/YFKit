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

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YFBaseRequest *)request {
    
    
    return [self filterUrl:originUrl request:request];
}


- (NSString *)filterUrl:(NSString *)originUrl request:(YFBaseRequest *)request {
    
    return originUrl;
}

@end
