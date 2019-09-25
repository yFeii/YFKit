//
//  YFBaseView.m
//  withMe
//
//  Created by lorabit on 15/12/2.
//  Copyright © 2015年 从来网络. All rights reserved.
//

#import "YFCornerView.h"

const UIRectCorner UIRectCornerNone = 99;

@implementation YFCornerView

-(instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if(self){
    [self setBackgroundColor:[UIColor clearColor]];
      _corner = 5;
  }
  return self;
}

-(void)setHighlighted:(BOOL)highlighted{
  _highlighted = highlighted;
  [self setNeedsDisplay];
}


-(void)setYF_backgroundColor:(UIColor *)YF_backgroundColor{
  _YF_backgroundColor = YF_backgroundColor;
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIColor* backgroundColor = self.highlighted?self.YF_highlightColor:self.YF_backgroundColor;
    CGContextRef drawCtx = UIGraphicsGetCurrentContext();
    UIBezierPath *path;
    
    CGRect tr = CGRectMake(self.border, self.border, rect.size.width-self.border*2, rect.size.height-self.border*2);
    if (self.cornerOption == UIRectCornerNone) {
        
        path = [UIBezierPath bezierPathWithRect:rect];
    }else{
        
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:self.cornerOption cornerRadii:CGSizeMake(self.corner,  self.border)];
    }

    [path setLineJoinStyle:kCGLineJoinRound];
    [backgroundColor setFill];
    [path fill];

    CGContextSaveGState(drawCtx);
    CGContextRestoreGState(drawCtx);
    CGFloat halfR = self.border/2.f;
    CGRect innerRect = CGRectMake(halfR, halfR, rect.size.width-self.border, rect.size.height-self.border);
    CGFloat radius = self.corner;
    CGFloat bw = self.border;
    if (self.borderOption & YFCellBorderTop) {
        
        CGContextSaveGState(drawCtx);
        CGContextTranslateCTM(drawCtx, innerRect.origin.x, innerRect.origin.y);
        CGContextMoveToPoint(drawCtx, 0, radius);
        CGContextAddArcToPoint(drawCtx, 0, 0, innerRect.size.width-radius, 0, radius);
        CGContextMoveToPoint(drawCtx, radius, 0);
        CGContextAddLineToPoint(drawCtx, innerRect.size.width-radius,0);
        CGContextMoveToPoint(drawCtx, innerRect.size.width-radius, 0);
        CGContextAddArcToPoint(drawCtx, innerRect.size.width, 0, innerRect.size.width, radius, radius);
        [self.YF_borderColor setStroke];
        CGContextSetLineWidth(drawCtx, bw);
        CGContextDrawPath(drawCtx, kCGPathStroke);
        CGContextRestoreGState(drawCtx);
    }
    
    if (self.borderOption & YFCellBorderBottom) {
        
        CGContextSaveGState(drawCtx);
        CGContextTranslateCTM(drawCtx, innerRect.origin.x, innerRect.origin.y);
        CGContextMoveToPoint(drawCtx, 0, innerRect.size.height-radius);
        CGContextAddArcToPoint(drawCtx, 0, innerRect.size.height, innerRect.size.width-radius, innerRect.size.height, radius);
        CGContextMoveToPoint(drawCtx, radius, innerRect.size.height);
        CGContextAddLineToPoint(drawCtx, innerRect.size.width-radius,innerRect.size.height);
        CGContextMoveToPoint(drawCtx, innerRect.size.width-radius, innerRect.size.height);
        CGContextAddArcToPoint(drawCtx, innerRect.size.width, innerRect.size.height, innerRect.size.width, innerRect.size.height-radius, radius);
        [self.YF_borderColor setStroke];
        CGContextSetLineWidth(drawCtx, bw);
        CGContextDrawPath(drawCtx, kCGPathStroke);
        CGContextRestoreGState(drawCtx);
    }
    //绘制左右描边
    if (self.borderOption & YFCellBorderLeftRight) {
        CGContextSaveGState(drawCtx);
//        CGContextTranslateCTM(drawCtx, innerRect.origin.x, innerRect.origin.y);
        //无圆角
        if (self.cornerOption == UIRectCornerNone) {
            CGContextMoveToPoint(drawCtx, innerRect.origin.x, 0);
            CGContextAddLineToPoint(drawCtx, innerRect.origin.x,rect.size.height);
            CGContextMoveToPoint(drawCtx, CGRectGetMaxX(innerRect),0);
            CGContextAddLineToPoint(drawCtx, CGRectGetMaxX(innerRect),rect.size.height);
        }else{
            
            if (self.cornerOption == (UIRectCornerTopRight | UIRectCornerTopLeft)) {
                //
                CGContextMoveToPoint(drawCtx, innerRect.origin.x, radius);
                CGContextAddLineToPoint(drawCtx, innerRect.origin.x,rect.size.height);
                CGContextMoveToPoint(drawCtx, CGRectGetMaxX(innerRect), radius);
                CGContextAddLineToPoint(drawCtx, CGRectGetMaxX(innerRect),rect.size.height);
            }else if(self.cornerOption == (UIRectCornerBottomLeft|UIRectCornerBottomRight)) {
                
                CGContextMoveToPoint(drawCtx, innerRect.origin.x, 0);
                CGContextAddLineToPoint(drawCtx, innerRect.origin.x,rect.size.height-radius);
                CGContextMoveToPoint(drawCtx, CGRectGetMaxX(innerRect), 0);
                CGContextAddLineToPoint(drawCtx, CGRectGetMaxX(innerRect),rect.size.height-radius);
            }else if (self.cornerOption == UIRectCornerAllCorners){
                
                CGContextMoveToPoint(drawCtx, 0, radius);
                CGContextAddLineToPoint(drawCtx, 0,innerRect.size.height-radius);
                CGContextMoveToPoint(drawCtx, innerRect.size.width, radius);
                CGContextAddLineToPoint(drawCtx, innerRect.size.width,innerRect.size.height-radius);
            }
        }
        
        
        [self.YF_borderColor setStroke];
        CGContextSetLineWidth(drawCtx, bw);
        CGContextDrawPath(drawCtx, kCGPathStroke);
        CGContextRestoreGState(drawCtx);
    }
}
@end
