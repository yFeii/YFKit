//
//  IMYWebView.h
//  IMY_ViewKit
//
//  Created by ljh on 15/7/1.
//  Copyright (c) 2015年 IMY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKScriptMessageHandler;
@class YFWebView, JSContext, WKWebView;

@protocol YFWebViewDelegate <NSObject>
@optional

- (void)webViewDidStartLoad:(YFWebView *)webView;
- (void)webViewDidFinishLoad:(YFWebView *)webView;
- (void)webView:(YFWebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(YFWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;


- (void)yf_observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context;

@end

///无缝切换UIWebView   会根据系统版本自动选择 使用WKWebView 还是  UIWebView
@interface YFWebView : UIView

///使用UIWebView
- (instancetype)initWithFrame:(CGRect)frame;

///会转接 WKUIDelegate，WKNavigationDelegate 内部未实现的回调。
@property (weak, nonatomic) id<YFWebViewDelegate> delegate;

///内部使用的webView
@property (nonatomic, readonly) WKWebView *realWebView;

///预估网页加载进度
@property (nonatomic, readonly) double estimatedProgress;

@property (nonatomic, readonly) NSURLRequest* originRequest;

@property (nonatomic, readonly) BOOL isLoadSuccess;

///WKWebView 跟网页进行交互的方法。
- (void)addScriptMessageHandler:(id<WKScriptMessageHandler>)scriptMessageHandler name:(NSString*)name;

///WKWebView 跟网页进行交互的方法。
- (void)removeScriptMessageHandler:(id<WKScriptMessageHandler>)scriptMessageHandler name:(NSString*)name;

///back 层数
- (NSInteger)countOfHistory;
- (void)gobackWithStep:(NSInteger)step;

///---- UI 或者 WK 的API
@property (nonatomic, readonly) UIScrollView* scrollView;

@property (nonatomic, readonly) UIProgressView *progressView;

- (id)loadRequest:(NSURLRequest*)request;
- (id)loadHTMLString:(NSString*)string baseURL:(NSURL*)baseURL;

@property (nonatomic, readonly, copy) NSString* title;
@property (nonatomic, readonly) NSURLRequest* currentRequest;
@property (nonatomic, readonly) NSURL* URL;

@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;

- (id)goBack;
- (id)goForward;
- (id)reload;
- (id)reloadFromOrigin;
- (void)stopLoading;

- (void)evaluateJavaScript:(NSString*)javaScriptString completionHandler:(void (^)(id, NSError*))completionHandler;
///不建议使用这个办法  因为会在内部等待webView 的执行结果
- (NSString*)stringByEvaluatingJavaScriptFromString:(NSString*)javaScriptString __deprecated_msg("Method deprecated. Use [evaluateJavaScript:completionHandler:]");

///是否根据视图大小来缩放页面  默认为YES
@property (nonatomic) BOOL scalesPageToFit;

@end
