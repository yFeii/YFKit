//
//  XHMaros.h
//  sqt-ios
//
//  Created by yFeii on 2019/7/1.
//  Copyright © 2019 yFeii. All rights reserved.
//

#ifndef YFMacros_h
#define YFMacros_h



#define toastViewFilter(view,msg,time)                         [view filter_makeToast:msg duration:time position:CSToastPositionCenter]
#define toasteView(view,msg,time)                              [view makeToast:msg duration:time position:CSToastPositionCenter]
#define toasteImageView(view,msg,time,imaged)                  [view makeToast:msg duration:time position:CSToastPositionCenter title:@"" image:imaged style:nil completion:nil]
#define WS(wSelf)                                              __weak typeof(self) wSelf = self
#define SS(sSelf)                                              __strong typeof(wSelf) sSelf = wSelf
#define dispatch_async_mainQueue(mainQueueBlock)               dispatch_async(dispatch_get_main_queue(), mainQueueBlock)
#define FormattedString(fmt,...)                               [NSString stringWithFormat:fmt,##__VA_ARGS__]
#define localTimestamp(num)                                    [NSNumber numberWithDouble:((NSNumber*)num).doubleValue/1000]

#define UIColorHexMake(str)                                    [UIColor colorWithHexString:str]

#define UIColorAHexMake(str,a)                                 [UIColor colorWithHexString:str alpha:a]

#define UIFontMake(size)                                       [UIFont systemFontOfSize:size]
#define UIFontBoldMake(size)                                   [UIFont boldSystemFontOfSize:size]

#define UIFontPF_Bold(boldSize)                                [UIFont fontWithName:@"PingFangSC-Blod" size:boldSize]
#define UIFont_DIN_Medium(boldSize)                            [UIFont fontWithName:@"DIN-Medium" size:boldSize]


#define USERDEFAULT                                           [NSUserDefaults standardUserDefaults]
#define K_ScreenWidth                                         [[XHTools tool] screenWidth]
#define K_ScreenHeight                                        [[XHTools tool] screenHeight]
#define YF_KeyWindow                                          [UIApplication sharedApplication].keyWindow



#endif /* YFMacros_h */
