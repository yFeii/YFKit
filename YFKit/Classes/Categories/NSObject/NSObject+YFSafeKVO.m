//
//  NSObject+SafeKVO.m
//  SafeKVO
//
//  Created by yFeii on 2019/8/2.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "NSObject+YFSafeKVO.h"

@implementation NSObject (YFSafeKVO)

- (void)safe_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context{
    
    NSLog(@"will add");
    if ([self observer:observer hasBeenAddedForKeyPath:keyPath] ) return;
    NSLog(@"add");
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
}

- (void)safe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context{
    if (![self observer:observer hasBeenAddedForKeyPath:keyPath]) return;
    [self removeObserver:observer forKeyPath:keyPath context:context];
}

- (void)safe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    if (![self observer:observer hasBeenAddedForKeyPath:keyPath]) return;
    [self removeObserver:observer forKeyPath:keyPath];
}

- (BOOL)observer:(NSObject *)observer hasBeenAddedForKeyPath:(NSString *)keyPath{
    id hasKVOInfo = self.observationInfo;
    if (hasKVOInfo) {
        // 以下 KVC 取值时需注意，如果 valueForKeyPath 的对象已经释放掉了，则有闪退的风险
        //场景：observer 已经 dealloc 但是却没有 移除KVO
        
        //取出所有添加KVO 的数组
        NSArray *observances = [hasKVOInfo valueForKey:@"_observances"];
        if (observances) {
            
            //objc 对象的类(NSKeyValueObservance)
            for (id observance in observances) {
                
                //接受KVO 的对象.
                id object = [observance valueForKeyPath:@"_observer"];
                //判断当前遍历对象 是否是正在添加通知的对象
                if (observer == object) {
                    //监听目标对象的属性(NSKeyValueProperty)
                    id Properties = [observance valueForKeyPath:@"_property"];
                    NSString *key = [Properties valueForKeyPath:@"_keyPath"];
                    if ([key isEqualToString:keyPath]) {
                        NSLog(@"has been added");
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}
@end
