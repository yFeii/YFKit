//
//  NSURL+YFAdditions.h
//  Masonry
//
//  Created by yFeii on 2019/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (YFAdditions)

/*
 * only useful for GET
 */
- (NSDictionary *)mapOfquery;

/*
 * nly useful for GET, same key`s value will be repleaced
 * value must be a object, it will be force transformed String.
 */
- (NSURL *)appendQueryKey:(NSString *)key value:(id)value;

@end

NS_ASSUME_NONNULL_END
