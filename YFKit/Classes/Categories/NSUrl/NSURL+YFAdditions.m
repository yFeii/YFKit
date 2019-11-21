//
//  NSURL+YFAdditions.m
//  Masonry
//
//  Created by yFeii on 2019/11/21.
//

#import "NSURL+YFAdditions.h"

@implementation NSURL (YFAdditions)

- (NSDictionary *)mapOfquery {
    NSString *param = [self.query stringByRemovingPercentEncoding];
    NSArray *arr = [param componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (NSString *keyValue in arr) {
        
        NSArray *arr = [keyValue componentsSeparatedByString:@"="];
        if (arr.count>1) {
            NSString *key = arr[0];
            NSString *value = arr[1];
            [dic setValue:value forKey:key];
        }
    }
    return dic;
}

- (NSURL *)appendQueryKey:(NSString *)key value:(id)value {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self mapOfquery]];
    [dic setValue:value forKey:key];
    NSMutableString *query = [[NSMutableString alloc] init];
    for (NSString *key in dic.allKeys) {
    
        NSString *value = [[dic valueForKey:key] description];
        if (value) {
            [query appendString:key];
            [query appendString:@"="];
            [query appendString:value];
            [query appendString:@"&"];
        }
    }
    if (query.length>0) {
        
        [query substringToIndex:query.length-1];
        
        NSArray *arr = [self.absoluteString componentsSeparatedByString:@"?"];
        NSString *oriUrlString = [arr firstObject];
        NSString *newUrl = [oriUrlString stringByAppendingString:[NSString stringWithFormat:@"?%@",query]];
        return [NSURL URLWithString:newUrl];
    }
    return nil;
}
@end
