//
//  NSNumber+YFAdd.h
//  sqt-ios
//
//  Created by yFeii on 2019/8/19.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (YFAdditions)


@end

@interface NSNumber (YFAlgorithm)
- (NSNumber *)numberFromPriceMultiply100;

- (NSNumber *)subtractPrice:(NSNumber *)price;
- (NSNumber *)addingPrice:(NSNumber *)price;
//- (NSString *)multiplyingPrice:(NSString *)priceString;
- (NSNumber *)multiplyingPrice:(NSNumber *)price needFix2:(BOOL)isFixed;
//舍弃小数点后两位
- (NSNumber *)multiplyingPriceAbandon2afterPoint:(NSNumber *)price;
@end

NS_ASSUME_NONNULL_END
