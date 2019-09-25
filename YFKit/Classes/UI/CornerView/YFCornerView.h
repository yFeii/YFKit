//
//  YFBaseView.h
//  withMe
//
//  Created by lorabit on 15/12/2.
//  Copyright © 2015年 从来网络. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, YFCellBorderOption) {
  YFCellBorderNone            = 0,
  YFCellBorderTop             = 1 << 0,
  YFCellBorderBottom          = 1 << 1,
  YFCellBorderLeftRight       = 1 << 2,
  YFCellBorderAll             = YFCellBorderBottom | YFCellBorderTop | YFCellBorderLeftRight
};

extern const UIRectCorner UIRectCornerNone;

@interface YFCornerView : UIView


@property(nonatomic)UIRectCorner cornerOption;
@property(nonatomic)YFCellBorderOption borderOption;


@property(nonatomic,copy)UIColor * YF_backgroundColor;
@property(nonatomic,copy)UIColor * YF_borderColor;
@property(nonatomic,copy)UIColor * YF_highlightColor;

@property(nonatomic,assign)CGFloat corner;
@property(nonatomic,assign)CGFloat border;
@property(nonatomic) BOOL highlighted;


@end
