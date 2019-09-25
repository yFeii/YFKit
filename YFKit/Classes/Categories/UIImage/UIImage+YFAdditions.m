//
//  UIImage+YFAdditions.m
//  sqt-ios
//
//  Created by yFeii on 2019/9/22.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "UIImage+YFAdditions.h"
#import <Accelerate/Accelerate.h>
#import <float.h>


@implementation UIImage (YFAdditions)

CGFloat wm_DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat wm_RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

+ (UIImage *)imageFromLayer:(CALayer *)layer {
    
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.opaque, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

+ (UIImage *)imageWithShadowSize:(CGSize)shadowSize blur:(float)blur andColor:(UIColor *)color{

    CGContextRef drawRef = UIGraphicsGetCurrentContext();
    CGContextSetShadowWithColor(drawRef, shadowSize, blur, color.CGColor);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
  // calculate the size of the rotated view's containing box for our drawing space
  UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
  CGAffineTransform t = CGAffineTransformMakeRotation(wm_DegreesToRadians(degrees));
  rotatedViewBox.transform = t;
  CGSize rotatedSize = rotatedViewBox.frame.size;
  
  // Create the bitmap context
  UIGraphicsBeginImageContext(rotatedSize);
  CGContextRef bitmap = UIGraphicsGetCurrentContext();
  
  // Move the origin to the middle of the image so we will rotate and scale around the center.
  CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
  
  //   // Rotate the image context
  CGContextRotateCTM(bitmap, wm_DegreesToRadians(degrees));
  
  // Now, draw the rotated/scaled image into the context
  CGContextScaleCTM(bitmap, 1.0, -1.0);
  CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
  
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
  
}
+ (UIImage *)screenShoot:(UIView *)view {
  
  UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size {
  
  UIImage *image = nil;
  UIGraphicsBeginImageContextWithOptions(size, NO, 0.);
  [color setFill];
  UIRectFill(CGRectMake(0, 0, size.width, size.height));
  image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)opaqueImageWithRenderColor:(UIColor *)color renderSize:(CGSize)size {
  UIImage *image = nil;
  UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
  [color setFill];
  UIRectFill(CGRectMake(0, 0, size.width, size.height));
  image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

- (UIImage *)scaleFitToSize:(CGSize)size {
  
  CGFloat scaleRate = MIN(size.width / self.size.width, size.height / self.size.height);
  return [self scaleImageToSize:size rate:scaleRate];
}

- (UIImage *)scaleFillToSize:(CGSize)size {
  
  CGFloat scaleRate = MAX(size.width / self.size.width, size.height / self.size.height);
  return [self scaleImageToSize:size rate:scaleRate];
}

+ (UIImage*)scaleDown:(UIImage*)image withSize:(CGSize)newSize {
  
  UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
  [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
  UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return scaledImage;
}

- (UIImage *)scaleImageToSize:(CGSize)size rate:(CGFloat)scaleRate {
  
  UIImage *image = nil;
  CGSize renderSize = CGSizeMake(self.size.width * scaleRate, self.size.height * scaleRate);
  CGFloat startX = size.width * 0.5 - renderSize.width * 0.5;
  CGFloat startY = size.height * 0.5 - renderSize.height * 0.5;
  
  CGImageAlphaInfo info = CGImageGetAlphaInfo(self.CGImage);
  BOOL opaque = (info == kCGImageAlphaNone) || (info == kCGImageAlphaNoneSkipFirst) || (info == kCGImageAlphaNoneSkipLast);
  
  UIGraphicsBeginImageContextWithOptions(size, opaque, 0.);
  UIColor *backgroundColor = opaque ? [UIColor whiteColor] : [UIColor clearColor];
  [backgroundColor setFill];
  UIRectFillUsingBlendMode(CGRectMake(0, 0, size.width, size.height), kCGBlendModeNormal);
  
  [self drawInRect:CGRectMake(startX, startY, renderSize.width, renderSize.height)];
  image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)imageWithSize:(CGSize)renderSize CornerRadius:(float)radius fillColor:(UIColor *)fillColor StrokeColor:(UIColor *)strokeColor {
  UIGraphicsBeginImageContextWithOptions(renderSize, NO, 0.);
  CGContextRef drawCtx = UIGraphicsGetCurrentContext();
  CGPathRef borderPath = CGPathCreateWithRoundedRect((CGRect){CGPointZero,renderSize}, radius, radius, NULL);
  CGContextAddPath(drawCtx, borderPath);
  if (strokeColor) {
    [strokeColor setStroke];
    CGContextDrawPath(drawCtx, kCGPathStroke);
  }
  if (fillColor) {
    [fillColor setFill];
    CGContextDrawPath(drawCtx, kCGPathFill);
  }
  UIImage *resImage = [UIGraphicsGetImageFromCurrentImageContext() resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius)];
  UIGraphicsEndImageContext();
  CGPathRelease(borderPath);
  
  return resImage;
}

-(UIImage *)imageWithCornerRadius:(float)radius{
  // 开始图形上下文
  UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
  
  // 获得图形上下文
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  // 设置一个范围
  CGRect innerRect = CGRectMake(0, 0, self.size.width, self.size.height);
  // 根据一个rect创建一个椭圆
  
  CGContextMoveToPoint(ctx, radius, 0);

  CGContextAddLineToPoint(ctx, innerRect.size.width - radius,0);
  CGContextAddArc(ctx, innerRect.size.width - radius, radius, radius, -0.5 *M_PI,0.0, 0);

  CGContextAddLineToPoint(ctx, innerRect.size.width, innerRect.size.height - radius);
  CGContextAddArc(ctx, innerRect.size.width - radius, innerRect.size.height - radius, radius,0.0,0.5 * M_PI,0);


  CGContextAddLineToPoint(ctx, radius, innerRect.size.height);
  CGContextAddArc(ctx, radius, innerRect.size.height - radius, radius,0.5 *M_PI, M_PI,0);

  CGContextAddLineToPoint(ctx, 0, radius);
  CGContextAddArc(ctx, radius, radius, radius,M_PI,1.5 * M_PI,0);

// 闭合路径
CGContextClosePath(ctx);
  // 裁剪
  CGContextClip(ctx);
  // 将原照片画到图形上下文
  [self drawInRect:innerRect];
  // 从上下文上获取剪裁后的照片
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  
  // 关闭上下文
  UIGraphicsEndImageContext();
  
  return newImage;
}

+ (UIImage *)imageWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)radius fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor {
  
  CGRect circleRect = CGRectMake(lineWidth , lineWidth, size.width-lineWidth*2, size.height-lineWidth*2);
  UIGraphicsBeginImageContextWithOptions(size, NO, 0.);
  CGContextRef drawCtx = UIGraphicsGetCurrentContext();
  CGPathRef renderPath = CGPathCreateWithRoundedRect(circleRect, radius, radius, NULL);
  CGContextAddPath(drawCtx, renderPath);
  
  if (strokeColor && fillColor) {
    [fillColor setFill];
    [strokeColor setStroke];
    
    CGContextDrawPath(drawCtx, kCGPathFillStroke);
  } else {
    if (fillColor) {
      [fillColor setFill];
      CGContextDrawPath(drawCtx, kCGPathFill);
    } else if (strokeColor) {
      [strokeColor setStroke];
      CGContextDrawPath(drawCtx, kCGPathStroke);
    }
  }
  
  UIImage *resImage = [UIGraphicsGetImageFromCurrentImageContext() resizableImageWithCapInsets:UIEdgeInsetsMake(lineWidth+radius, lineWidth+radius, lineWidth+radius, lineWidth+radius)];
  UIGraphicsEndImageContext();
  CGPathRelease(renderPath);
  
  return resImage;
}

-(NSData*)jpegDataWithQuality:(float )quality Size:(int) size{
  NSData* data;
  if(size == 0){
    data = UIImageJPEGRepresentation(self, quality);
    return data;
  }else{
    CGSize  newSize;
    if(self.size.height>self.size.width){
      newSize = CGSizeMake(size, size/self.size.width*self.size.height);
    }else{
      newSize = CGSizeMake(size/self.size.height*self.size.width, size);
    }
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    data = UIImageJPEGRepresentation(newImage, quality);
    return data;
  }
}


- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius {
    return [self imageByRoundCornerRadius:radius borderWidth:0 borderColor:nil];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor {
    return [self imageByRoundCornerRadius:radius
                                  corners:UIRectCornerAllCorners
                              borderWidth:borderWidth
                              borderColor:borderColor
                           borderLineJoin:kCGLineJoinMiter];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin {
    
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)cutImage:(CGRect)rect
{
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}


//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


+ (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    //UIImage *image = [UIImage imageWithCGImage:quartzImage];
    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:1.0f orientation:UIImageOrientationRight];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
}

- (UIImage *)addImageLogo:(NSString *)logoStr {
    
    UIImage * videoIcon = [UIImage imageNamed:logoStr];
    return [self addImageLogo:self text:videoIcon];
}

- (UIImage*) imageWithUIView:(UIView*) view{
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}
//增加视频水印
-(UIImage *)addImageLogo:(UIImage *)img text:(UIImage *)logo
{
    
    int w = img.size.width;
    int h = img.size.height;
    CGRect rect = CGRectMake((w - w / 2) / 2, (h - h / 2) / 2, w / 2, h / 2);
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    [logo drawInRect:rect];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return aimg;
}

- (UIImage *)originalRenderingMode {
    
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end



@implementation UIImage (ImageEffects)


- (UIImage *)applyLightEffect
{
  UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
  return [self applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyExtraLightEffect
{
  UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
  return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyDarkEffect
{
  UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
  return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor
{
  const CGFloat EffectColorAlpha = 0.6;
  UIColor *effectColor = tintColor;
  int componentCount = (int)CGColorGetNumberOfComponents(tintColor.CGColor);
  if (componentCount == 2) {
    CGFloat b;
    if ([tintColor getWhite:&b alpha:NULL]) {
      effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
    }
  }
  else {
    CGFloat r, g, b;
    if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
      effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
    }
  }
  return [self applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}


- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
  // Check pre-conditions.
  if (self.size.width < 1 || self.size.height < 1) {
    NSLog(@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
    return nil;
  }
  if (!self.CGImage) {
    NSLog (@"*** error: image must be backed by a CGImage: %@", self);
    return nil;
  }
  if (maskImage && !maskImage.CGImage) {
    NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
    return nil;
  }
  
  CGRect imageRect = { CGPointZero, self.size };
  UIImage *effectImage = self;
  
  BOOL hasBlur = blurRadius > __FLT_EPSILON__;
  BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
  if (hasBlur || hasSaturationChange) {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef effectInContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(effectInContext, 1.0, -1.0);
    CGContextTranslateCTM(effectInContext, 0, -self.size.height);
    CGContextDrawImage(effectInContext, imageRect, self.CGImage);
    
    vImage_Buffer effectInBuffer;
    effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
    effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
    effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
    effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
    vImage_Buffer effectOutBuffer;
    effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
    effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
    effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
    effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
    
    if (hasBlur) {
      // A description of how to compute the box kernel width from the Gaussian
      // radius (aka standard deviation) appears in the SVG spec:
      // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
      //
      // For larger values of 's' (s >= 2.0), an approximation can be used: Three
      // successive box-blurs build a piece-wise quadratic convolution kernel, which
      // approximates the Gaussian kernel to within roughly 3%.
      //
      // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
      //
      // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
      //
      CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
      uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
      if (radius % 2 != 1) {
        radius += 1; // force radius to be odd so that the three box-blur methodology works.
      }
      vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
      vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
      vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
    }
    BOOL effectImageBuffersAreSwapped = NO;
    if (hasSaturationChange) {
      CGFloat s = saturationDeltaFactor;
      CGFloat floatingPointSaturationMatrix[] = {
        0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
        0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
        0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
        0,                    0,                    0,  1,
      };
      const int32_t divisor = 256;
      NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
      int16_t saturationMatrix[matrixSize];
      for (NSUInteger i = 0; i < matrixSize; ++i) {
        saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
      }
      if (hasBlur) {
        vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
        effectImageBuffersAreSwapped = YES;
      }
      else {
        vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
      }
    }
    if (!effectImageBuffersAreSwapped)
      effectImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (effectImageBuffersAreSwapped)
      effectImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  
  // Set up output context.
  UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
  CGContextRef outputContext = UIGraphicsGetCurrentContext();
  CGContextScaleCTM(outputContext, 1.0, -1.0);
  CGContextTranslateCTM(outputContext, 0, -self.size.height);
  
  // Draw base image.
  CGContextDrawImage(outputContext, imageRect, self.CGImage);
  
  // Draw effect image.
  if (hasBlur) {
    CGContextSaveGState(outputContext);
    if (maskImage) {
      CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
    }
    CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
    CGContextRestoreGState(outputContext);
  }
  
  // Add in color tint.
  if (tintColor) {
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
    CGContextFillRect(outputContext, imageRect);
    CGContextRestoreGState(outputContext);
  }
  
  // Output image is ready.
  UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return outputImage;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
  UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, 0, self.size.height);
  CGContextScaleCTM(context, 1.0, -1.0);
  CGContextSetBlendMode(context, kCGBlendModeNormal);
  CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
  CGContextClipToMask(context, rect, self.CGImage);
  [color setFill];
  CGContextFillRect(context, rect);
  UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}


@end
