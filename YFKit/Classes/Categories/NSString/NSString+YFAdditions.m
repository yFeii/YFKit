//
//  NSString+YFAdditionals.m
//  sqt-ios
//
//  Created by yFeii on 2019/9/18.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "NSString+YFAdditions.h"
#import "NSDate+YFAdditions.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>

#define MD5_CHAR_TO_STRING_16 [NSString stringWithFormat:               \
@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",    \
result[0], result[1], result[2], result[3],                             \
result[4], result[5], result[6], result[7],                             \
result[8], result[9], result[10], result[11],                           \
result[12], result[13], result[14], result[15]]


#pragma mark <(YFAdditions)>

@implementation NSString (YFAdditions)
+ (NSString *)joinedByString:(NSString *)string otherStrings:(NSString *)otherStrings, ... NS_REQUIRES_NIL_TERMINATION{

    NSMutableArray *otherArray = [[NSMutableArray alloc] init];
    if(![YFTools isStringEmpty:otherStrings]){
        [otherArray addObject:otherStrings];
    }
    //定义一个 va_list 指针来访问参数表
    va_list argList;
     //初始化 va_list，让它指向第一个变参，otherButtonTitles 这里是第一个参数，虽然加了s,它不是数组。
    va_start(argList, otherStrings);
    NSString *arg;
    //调用 va_arg 依次取出 参数，它会自带指向下一个参数
    while ((arg = va_arg(argList, id))) {
        
        if(![YFTools isStringEmpty:arg]){
            [otherArray addObject:arg];
        }
    }
    va_end(argList); // 收尾，记得关闭关闭 va_list
    
    return [otherArray componentsJoinedByString:string];
}


+ (NSString *)base64EncodedStringFromString:(NSString *)string {
    NSData *data = [NSData
                    dataWithBytes:[string UTF8String]
                    length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData =
    [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *) [data bytes];
    uint8_t *output = (uint8_t *) [mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length
        ? kAFBase64EncodingTable[(value >> 6) & 0x3F]
        : '=';
        output[idx + 3] = (i + 2) < length
        ? kAFBase64EncodingTable[(value >> 0) & 0x3F]
        : '=';
    }
    
    return [[NSString alloc] initWithData:mutableData
                                 encoding:NSASCIIStringEncoding];
}

+ (NSString *)base64EncodedString:(NSString *)string {
    
    NSData *encodeData = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [encodeData base64EncodedStringWithOptions:0];
}



- (id)MD5 {
    
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return MD5_CHAR_TO_STRING_16;
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    
    if (pinYin.length>0) {
        pinYin = [pinYin substringToIndex:1];
        NSString *regex =@"[A-Za-z]+";
        NSPredicate*predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        BOOL result = [predicate evaluateWithObject:pinYin];
        if (result) {
            return pinYin;
        }
    }
    return @"#";
}


@end


#pragma mark <(YFSizeHelper)>

@implementation NSString (YFSizeHelper)
- (CGSize)boundingWithMaxSize:(CGSize)size Attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes{
    
    return [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading  attributes:attributes context:nil].size;
}

@end


@implementation NSAttributedString (YFSizeHelper)

- (CGSize)boundingWithMaxSize:(CGSize)size{
    
    return [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading  context:nil].size;
}

@end

#pragma mark <(YFDateHelper)>

@implementation NSString (YFDateHelper)

- (NSDate *)dateFromStringWithYearAndMinute {
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    return [outputFormatter dateFromString:self];
}

- (NSDate *)dateFromStringWithPointDate{
  
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    return [outputFormatter dateFromString:self];
}

- (NSString *)yearMonthDayHourMinuteFormattedString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSDate *date = [self dateFromString];
    
    NSDateFormatter *formatterStr = [[NSDateFormatter alloc] init] ;
    [formatterStr setDateFormat:@"YYYY-MM-dd HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSString *res = [formatterStr stringFromDate:date];
    return res;
}

- (NSDate *)dateFromString {
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [outputFormatter dateFromString:self];
}

+ (NSString *)stringWithTimelineDate:(NSDate *)date {
    if (!date) return @"";
    
    static NSDateFormatter *formatterYesterday;
    static NSDateFormatter *formatterSameYear;
    static NSDateFormatter *formatterFullDate;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterYesterday = [[NSDateFormatter alloc] init];
        [formatterYesterday setDateFormat:@"昨天 HH:mm"];
        [formatterYesterday setLocale:[NSLocale currentLocale]];
        
        formatterSameYear = [[NSDateFormatter alloc] init];
        [formatterSameYear setDateFormat:@"M-d"];
        [formatterSameYear setLocale:[NSLocale currentLocale]];
        
        formatterFullDate = [[NSDateFormatter alloc] init];
        [formatterFullDate setDateFormat:@"yy-M-dd"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
    });
    
    NSDate *now = [NSDate new];
    NSTimeInterval delta = now.timeIntervalSince1970 - date.timeIntervalSince1970;
    if (delta < -60 * 10) { // 本地时间有问题
        return [formatterFullDate stringFromDate:date];
    } else if (delta < 60 * 60) { // 1小时内
        if (delta<60) {
            return @"刚刚";
        }
        return [NSString stringWithFormat:@"%d分钟前", (int)(delta / 60.0)];
    } else if (date.isToday) {
        return [NSString stringWithFormat:@"%d小时前", (int)(delta / 60.0 / 60.0)];
    } else if (date.isYesterday) {
        return [formatterYesterday stringFromDate:date];
    } else if (date.year == now.year) {
        return [formatterSameYear stringFromDate:date];
    } else {
        return [formatterFullDate stringFromDate:date];
    }
}


+ (NSString *)stringWithGroupByDayTimelineDate:(NSDate *)date {
    if (!date) return @"";
    
    static NSDateFormatter *formatterSameYear;
    static NSDateFormatter *formatterFullDate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      
        formatterSameYear = [[NSDateFormatter alloc] init];
        [formatterSameYear setDateFormat:@"M-d"];
        [formatterSameYear setLocale:[NSLocale currentLocale]];
        
        formatterFullDate = [[NSDateFormatter alloc] init];
        [formatterFullDate setDateFormat:@"yy-M-dd"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
    });
    
    NSDate *now = [NSDate new];
    NSTimeInterval delta = now.timeIntervalSince1970 - date.timeIntervalSince1970;
    if (delta < -60 * 10) { // 本地时间有问题
        return [formatterFullDate stringFromDate:date];
    } else if (date.isToday) {
        return @"今天";
    } else if (date.isYesterday) {
        return @"昨天";
    } else if (date.year == now.year) {
        return [formatterSameYear stringFromDate:date];
    } else {
        return [formatterFullDate stringFromDate:date];
    }
}

@end


#pragma mark <YFPriceHelper>

@implementation NSString (YFPriceHelper)


- (NSNumber *)numberFromPriceMultiply100{
    
    NSDecimalNumber *number;
    if ([YFTools isStringEmpty:self]) {

       number = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        number = [NSDecimalNumber decimalNumberWithString:self];
    }
    
    number = [number decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    return number;
}



- (NSString *)subtractPrice:(NSString *)priceString{
    
    NSNumber *t_self;
    if ([YFTools isStringEmpty:self]) {
        
        t_self = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_self = [NSDecimalNumber decimalNumberWithString:self];
    }
    
    NSNumber *t_num;
    if ([YFTools isStringEmpty:priceString]) {
        
        t_num = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_num = [NSDecimalNumber decimalNumberWithString:priceString];
    }

    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[t_self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[t_num decimalValue]];
    NSDecimalNumber *result = [tempNum decimalNumberBySubtracting:targetNum];//相减
    return [NSString stringWithFormat:@"%@", result];
}

- (NSString *)addingPrice:(NSString *)priceString{
    
    NSNumber *t_self;
    if ([YFTools isStringEmpty:self]) {
        
        t_self = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_self = [NSDecimalNumber decimalNumberWithString:self];
    }
    
    NSNumber *t_num;
    if ([YFTools isStringEmpty:priceString]) {
        
        t_num = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_num = [NSDecimalNumber decimalNumberWithString:priceString];
    }
    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[t_self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[t_num decimalValue]];
    NSDecimalNumber *result = [tempNum decimalNumberByAdding:targetNum];
    return [NSString stringWithFormat:@"%@", result];
}

- (NSString *)multiplyingPrice:(NSString *)priceString needFix2:(BOOL)isFixed {
    
    NSNumber *t_self;
    if ([YFTools isStringEmpty:self]) {
        
        t_self = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_self = [NSDecimalNumber decimalNumberWithString:self];
    }
    
    NSNumber *t_num;
    if ([YFTools isStringEmpty:priceString]) {
        
        t_num = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_num = [NSDecimalNumber decimalNumberWithString:priceString];
    }
    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[t_self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[t_num decimalValue]];
    NSDecimalNumber *result = [tempNum decimalNumberByMultiplyingBy:targetNum];
    if (isFixed) {
        return [NSString stringWithFormat:@"%.2f", [result doubleValue]];
    }
    return [NSString stringWithFormat:@"%@", result];
}

- (NSString *)multiplyingPriceAbandon2afterPoint:(NSString *)priceString  {
    
    NSNumber *t_self;
    if ([YFTools isStringEmpty:self]) {
        
        t_self = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_self = [NSDecimalNumber decimalNumberWithString:self];
    }
    
    NSNumber *t_num;
    if ([YFTools isStringEmpty:priceString]) {
        
        t_num = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_num = [NSDecimalNumber decimalNumberWithString:priceString];
    }
    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[t_self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[t_num decimalValue]];

    //舍弃后两位
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];

    NSDecimalNumber *result = [tempNum decimalNumberByMultiplyingBy:targetNum withBehavior:handel];
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];

}
@end
