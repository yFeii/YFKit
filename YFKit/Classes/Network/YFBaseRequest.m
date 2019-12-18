//
//  KDTTBaseRequestModel.m
//  KanDianTouTiao
//
//  Created by Jiansi on 2018/7/17.
//  Copyright © 2018年 Calvien. All rights reserved.
//

#import "YFBaseRequest.h"
#import "YFResponseConcentrateHandler.h"
#import "YFRequestConcentrateHandler.h"
#import "YFAPIUtils.h"

@interface YFBaseRequest()<YTKRequestDelegate>

@property (nonatomic, assign) YFBaseRequestTaskState reqTaskState;
@end

@implementation YFBaseRequest

- (void)dealloc {
    
    NSLog(@"dealloc");
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.delegate = self;
        _reqTaskState = YFBaseRequestTaskStateNormal;
        if ([self conformsToProtocol:@protocol(YFBaseRequestProtocol)]) {
            
            self.child = (id<YFBaseRequestProtocol>)self;
        }else{
            NSException *ex = [NSException exceptionWithName:@"YFBaseRequestProtocol error" reason:@"YFBaseRequest子类必须遵循 <YFBaseRequestProtocol> 协议" userInfo:nil];
            @throw ex;
        }
        if ([self conformsToProtocol:@protocol(YFBaseRequestValidator)]) {
            
            self.validator = (id<YFBaseRequestValidator>)self;
        }
    }
    return self;
}

- (void)startRequest{


}

- (void)fetchData {
    
    if ([self.validator respondsToSelector:@selector(request:isCorrectWithParamsData:)]) {
        
        if (![self.validator request:self isCorrectWithParamsData:[self requestArgument]]) {
            [self requestFailed:self];
            return;
        }
    }
    
    self.reqTaskState = YFBaseRequestTaskStateIsSending;
    [super start];
}

- (YFBaseRequestTaskState)taskState {
    
    return self.reqTaskState;
}


- (NSTimeInterval)requestTimeoutInterval {
    
    if ([self.child respondsToSelector:@selector(requestTimeout)]) {
        return [self.child requestTimeout];
    }
    return 10;
}


#pragma mark - <override mothed>

- (YTKRequestSerializerType)requestSerializerType {
    
    if ([self.child respondsToSelector:@selector(requestSerializationType)]) {
        YTKRequestSerializerType type = (YTKRequestSerializerType)[self.child requestSerializationType];
        return type;
    }
    return YTKRequestSerializerTypeHTTP;
}

- (NSString *)requestUrl {
    
    NSString *urlString = [self.child requestMethodName];
    
    return urlString;
}

- (NSString *)baseUrl {
    
    if ([self.child respondsToSelector:@selector(domainString)]) {
        return [self.child domainString];
    }
    return [[YFAPIUtils shareInstance] baseUrl];
}

- (id)requestArgument {
    
    id param = [self.child requestParams];
    return param;
}


- (YTKRequestMethod)requestMethod {
    
    YFBaseRequestType type = [self.child requestMethodType];
    switch (type) {
            
        case YFBaseRequestTypeGET:
            return YTKRequestMethodGET;
        case YFBaseRequestTypePOST:
            return YTKRequestMethodPOST;
        case YFBaseRequestTypePUT:
            return YTKRequestMethodPUT;
        case YFBaseRequestTypeDELETE:
            return YTKRequestMethodDELETE;
    }
    return YTKRequestMethodPOST;
}


- (id)resultContent {
    
    id resp = self.responseObject;
    if (resp) {
        if ([resp isKindOfClass:[NSDictionary class]]) {
            
            return resp[@"data"];
        }
    }
    return nil;
}

- (void)cancelRequest {

    [self stop];
}
#pragma mark - Subclass Override

- (void)requestCompletePreprocessor {

}

- (void)requestCompleteFilter {

}

- (void)requestFailedPreprocessor {

}

- (void)requestFailedFilter {
    
    
}

#pragma mark -- <private method>


#pragma mark -- <YTKRequestDelegate>
- (void)requestFinished:(__kindof YTKBaseRequest *)request{
    //没个公司的业务成功评定条件都不一样 这里提供一个切面
    if ([self resultFilter:request]) {
        
        if ([self.interceptor respondsToSelector:@selector(requestDidFinishedBeforeCallBack)]) {
            
            [self.interceptor requestDidFinishedBeforeCallBack];
        }
        
        if ([self.callBackDelegate respondsToSelector:@selector(requestDidFinished:)]) {
            
            [self.callBackDelegate requestDidFinished:request];
            self.reqTaskState = YFBaseRequestTaskStateCallBackDone;
        }
    }else{
        [self requestFailed:request];
    }
}

- (void)requestFailed:(__kindof YTKBaseRequest *)request{

    if (self.errorMsg.length<=0) {
        
        self.errorMsg = [request.error.userInfo objectForKey:@"NSLocalizedDescription"];
    }
    if ([self.interceptor respondsToSelector:@selector(requestDidFailedBeforeCallBack)]) {
        
        [self.interceptor requestDidFailedBeforeCallBack];
    }
    if ([self.callBackDelegate respondsToSelector:@selector(requestDidFailed:)]) {
        
        if ([[YFResponseConcentrateHandler shareInstance] handleEventWithResponse:request]) {
            [self.callBackDelegate requestDidFailed:request];
        }
    }
    self.reqTaskState = YFBaseRequestTaskStateCallBackDone;
}

- (BOOL)resultFilter:(__kindof YTKBaseRequest *)request {
    
    //通用业务场景下成功
    if ([[YFResponseConcentrateHandler shareInstance] businessIsSuccess:request]) {
        if (self.validator && [self.validator respondsToSelector:@selector(request:isCorrectWithCallBackData:)]) {
            //特殊业务场景
            return [self.validator request:self isCorrectWithCallBackData:[request resultContent]];
        }
        return YES;
    }
    return NO;
}
@end
