//
//  CAGradientLayers+YFAdditions.m
//  sqt-ios
//
//  Created by yFeii on 2019/9/19.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "CAGradientLayer+YFAdditions.h"

@implementation CAGradientLayer (YFGradual)
+ (CAGradientLayer *)layerWithColors:(NSArray *)colors direction:(CAGradientLayerDirection)direction withFrame:(CGRect)frame {
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = colors;
    layer.frame = frame;
    layer.locations = @[@0,@1];
    if (direction == CAGradientLayerDirectionVertical) {
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(0, 1);
    }else{
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(1, 0);
    }
    return layer;
}
@end

@implementation CAGradientLayer (YFAdditions)

@end
