//
//  CAGradientLayers+YFAdditions.h
//  sqt-ios
//
//  Created by yFeii on 2019/9/19.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, CAGradientLayerDirection) {
    CAGradientLayerDirectionVertical,
    CAGradientLayerDirectionHorizontal,
};

@interface CAGradientLayer (YFGradual)

+ (CAGradientLayer *)layerWithColors:(NSArray *)colors direction:(CAGradientLayerDirection)direction withFrame:(CGRect)frame;

@end


@interface CAGradientLayer (YFAdditions)

@end

NS_ASSUME_NONNULL_END
