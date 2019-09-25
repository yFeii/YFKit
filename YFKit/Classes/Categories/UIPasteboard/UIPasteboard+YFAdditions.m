//
//  UIPasteboard+YFAdditionals.m
//  sqt-ios
//
//  Created by yFeii on 2019/9/16.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "UIPasteboard+YFAdditions.h"
#import <MobileCoreServices/UTCoreTypes.h>
@implementation UIPasteboard (YFAdditions)

- (void)setAttributedString:(NSAttributedString *)attributedString {
    NSString *String = [[attributedString string] stringByReplacingOccurrencesOfString:@"\ufffc" withString:@""];
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithCapacity:1];
    [item setValue:String forKey:(NSString *)kUTTypeText];
    self.items = [NSArray arrayWithObject:item];
}


@end
