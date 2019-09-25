//
//  UICollectionView+Fitter.m
//  HGOrderingMerchant
//
//  Created by ShiGY on 2017/10/26.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import "UICollectionView+YFAdditions.h"
#import "objc/runtime.h"

@implementation UICollectionView (YFAdditions)

+(void)load {
    
    swizzled_Method([self class], @selector(initWithFrame:collectionViewLayout:), @selector(after_initWithFrame:collectionViewLayout:));
    
}

- (instancetype)after_initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    UICollectionView *collectionView = [self after_initWithFrame:frame collectionViewLayout:layout];
    if (collectionView) {
        
        if (@available(iOS 11.0,*)) {
            collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return collectionView;
}

@end
