//
//  NSString+YFAdditionals.h
//  sqt-ios
//
//  Created by yFeii on 2019/9/18.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark <YFAdditions>

@interface NSString (YFAdditions)

+ (NSString *)joinedByString:(NSString *)string otherStrings:(NSString *)otherStrings, ... NS_REQUIRES_NIL_TERMINATION;

+ (NSString *)base64EncodedStringFromString:(NSString *)string;

+ (NSString *)base64EncodedString:(NSString *)string;

- (id)MD5;

- (NSString *)firstCharactor;

@end

#pragma mark <YFDateHelper>

@interface NSString (YFDateHelper)

- (NSDate *)dateFromStringWithYearAndMinute;
- (NSDate *)dateFromStringWithPointDate;

- (NSString *)yearMonthDayHourMinuteFormattedString;

+ (NSString *)stringWithTimelineDate:(NSDate *)date;
+ (NSString *)stringWithGroupByDayTimelineDate:(NSDate *)date;

@end

#pragma mark <YFPriceHelper>

@interface NSString (YFPriceHelper)

- (NSNumber *)numberFromPriceMultiply100;

- (NSString *)subtractPrice:(NSString *)priceString;
- (NSString *)addingPrice:(NSString *)priceString;
- (NSString *)multiplyingPrice:(NSString *)priceString needFix2:(BOOL)isFixed;

//舍弃小数点后两位
- (NSString *)multiplyingPriceAbandon2afterPoint:(NSString *)priceString;
@end

#pragma mark <YFSizeHelper>

@interface NSString (YFSizeHelper)


- (CGSize)boundingWithMaxSize:(CGSize)size Attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes;
@end


@interface NSAttributedString (YFSizeHelper)

- (CGSize)boundingWithMaxSize:(CGSize)size;
@end
NS_ASSUME_NONNULL_END
