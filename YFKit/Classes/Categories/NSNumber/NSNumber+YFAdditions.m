//
//  NSNumber+YFAdd.m
//  sqt-ios
//
//  Created by yFeii on 2019/8/19.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "NSNumber+YFAdditions.h"

@implementation NSNumber (YFAdditions)

@end

@implementation NSNumber (YFAlgorithm)
- (NSNumber *)numberFromPriceMultiply100{
    
    NSDecimalNumber *number = [(NSDecimalNumber *)self decimalNumberByMultiplyingBy:(NSDecimalNumber *)@100];
    return number;
}

- (NSNumber *)subtractPrice:(NSNumber *)price{
    
    if (!price) {
        price = @0;
    }
    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[price decimalValue]];
    NSDecimalNumber *result = [tempNum decimalNumberBySubtracting:targetNum];//相减
    return result;
}

- (NSNumber *)addingPrice:(NSNumber *)price{
    
    if (!price) {
        price = @0;
    }
    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[price decimalValue]];
    NSDecimalNumber *result = [tempNum decimalNumberByAdding:targetNum];
    return result;
}

- (NSNumber *)multiplyingPrice:(NSNumber *)price needFix2:(BOOL)isFixed {
   
    if (!price) {
        price = @0;
    }
    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[price decimalValue]];
    NSDecimalNumber *result;
    if (isFixed) {
        NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        result = [tempNum decimalNumberByMultiplyingBy:targetNum withBehavior:handel];
    }else{
        result = [tempNum decimalNumberByMultiplyingBy:targetNum];
    }
    return result;
}

- (NSNumber *)multiplyingPriceAbandon2afterPoint:(NSNumber *)price  {
    
   
    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[price decimalValue]];
    
    //舍弃后两位
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *result = [tempNum decimalNumberByMultiplyingBy:targetNum withBehavior:handel];
    return result;
    
}

@end
