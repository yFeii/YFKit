//
//  YFAPIUtils.m
//  sqt-ios
//
//  Created by yFeii on 2019/8/30.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "YFAPIUtils.h"


@interface YFAPIUtils()
@property (nonatomic, strong) NSDictionary *authToken;
@property (nonatomic, strong) NSDictionary *commonParam;
@end

@implementation YFAPIUtils
+ (instancetype)shareInstance {
    
    static YFAPIUtils *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YFAPIUtils alloc] init];
    });
    return sharedInstance;
}


- (void)PublicParameters:(NSDictionary *)param {
    self.commonParam = param;
}

- (NSString *)baseUrl {
    

    switch (self.serviceEnv) {
        case YFRequestEnvironmentTypeProduction:
            return self.baseUrlProduction;
        case YFRequestEnvironmentTypeDevelop:
            return self.baseUrlDevelop;
        case YFRequestEnvironmentTypeTest:
            return self.baseUrlTest;
        case YFRequestEnvironmentTypePrerelease:
            return self.baseUrlPrerelease;
        default:
            break;
    }
}

@end
