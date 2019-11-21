//
//  YFAPIUtils.h
//  sqt-ios
//
//  Created by yFeii on 2019/8/30.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, YFRequestEnvironmentType) {
    
    YFRequestEnvironmentTypeProduction,
    YFRequestEnvironmentTypeDevelop,
    YFRequestEnvironmentTypeTest,
    YFRequestEnvironmentTypePrerelease
};

@interface YFAPIUtils : NSObject

// 域名配置项
// 服务端地址(正式环境)
@property (nonatomic, strong) NSString *baseUrlProduction;

// 服务端地址(测试环境)
@property (nonatomic, strong) NSString *baseUrlTest;

// 服务端地址(开发环境)
@property (nonatomic, strong) NSString *baseUrlDevelop;

// 服务端地址(预发环境)
@property (nonatomic, strong) NSString *baseUrlPrerelease;


// 服务端环境
@property (nonatomic, assign) YFRequestEnvironmentType serviceEnv;

// api版本
@property (nonatomic, assign) NSString *apiVersion;

// 公共参数,除了api版本
@property (nonatomic, strong, readonly) NSDictionary *commonParam;

// 网络状态
@property (nonatomic, assign, readonly) BOOL isReachable;

+ (instancetype)shareInstance;

/**
 * @param param 公共参数
 */
- (void)PublicParameters:(NSDictionary *)param;


/**
 * 根据当前配置的网络环境返回请求域名
 */
- (NSString *)baseUrl;
@end

NS_ASSUME_NONNULL_END
