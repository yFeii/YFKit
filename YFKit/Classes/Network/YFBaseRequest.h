//
//  KDTTBaseRequestModel.h
//  KanDianTouTiao
//
//  Created by Jiansi on 2018/7/17.
//  Copyright © 2018年 Calvien. All rights reserved.
//

#import "YTKRequest.h"

@class YFBaseRequest;

typedef NS_ENUM(NSUInteger, YFBaseRequestType) {
    YFBaseRequestTypeGET = 0,
    YFBaseRequestTypePOST,
    YFBaseRequestTypePUT,
    YFBaseRequestTypeDELETE,
};

///  Request serializer type.
typedef NS_ENUM(NSInteger, YFRequestSerializerType) {
    YFRequestSerializerTypeHTTP = 0,
    YFRequestSerializerTypeJSON,
};

///  Response serializer type, which determines response serialization process and
///  the type of `responseObject`.
typedef NS_ENUM(NSInteger, YFResponseSerializerType) {
    /// NSData type
    YFResponseSerializerTypeHTTP,
    /// JSON object type
    YFResponseSerializerTypeJSON,
    /// NSXMLParser type
    YFResponseSerializerTypeXMLParser,
};

typedef NS_ENUM(NSUInteger, YFBaseRequestTaskState) {
    YFBaseRequestTaskStateNormal,             //没发送的状态，闲置
    YFBaseRequestTaskStateIsSending,          //正在请求中
    YFBaseRequestTaskStateCallBackDone,       //回调完成
};

typedef void(^YFRequestSuccessBlock)(__kindof YFBaseRequest *request);
typedef void(^YFRequestFailedBlock)(__kindof YFBaseRequest *request);

@protocol YFBaseRequestProtocol<NSObject>

@required
- (NSString *)requestMethodName;
- (YFBaseRequestType)requestMethodType;
- (id)requestParams;

@optional
- (NSString *)domainString;
- (NSTimeInterval)requestTimeout;

///  Request serializer type.
- (YFRequestSerializerType)requestSerializationType;

///  Response serializer type. See also `responseObject`.
- (YFResponseSerializerType)responseSerializationType;

@end

@protocol YFBaseRequestValidator<NSObject>

@required
//请求参数是否合法
- (BOOL)request:(YFBaseRequest *)request isCorrectWithParamsData:(NSDictionary *)data;

@optional
- (BOOL)checkRequestParams;
- (BOOL)request:(YFBaseRequest *)request isCorrectWithCallBackData:(NSDictionary *)data;
@end

@protocol YFBaseRequestInterceptor<NSObject>

@optional
- (void)requestDidFinishedBeforeCallBack;
- (void)requestDidFailedBeforeCallBack;
@end


@protocol YFBaseRequestCallBackDelegate<NSObject>

- (void)requestDidFinished:(__kindof YFBaseRequest *)request;
- (void)requestDidFailed:(__kindof YFBaseRequest *)request;
@end


@interface YFBaseRequest : YTKRequest

@property (nonatomic, weak) NSObject<YFBaseRequestProtocol> *child;
@property (nonatomic, weak) NSObject<YFBaseRequestInterceptor> *interceptor;
@property (nonatomic, weak) NSObject<YFBaseRequestValidator> *validator;
@property (nonatomic, weak) NSObject<YFBaseRequestCallBackDelegate> *callBackDelegate;

@property (nonatomic, assign, readonly) BOOL shouldIgnoreError;
@property (nonatomic, copy) NSString *errorMsg;




- (void)fetchData;
- (void)cancelRequest;
- (id)resultContent;

- (YFBaseRequestTaskState)taskState;

@end
