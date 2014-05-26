//
//  UIImage+ARExtensions.h
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ARExtensions)

+ (UIImage *)imageWithView:(UIView *)view;

+ (UIImage *)imageWithColor:(UIColor *)color
                  dimension:(int)dimension;

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
                     radius:(float)cornerRadius;

+ (UIImage *)imageWithSize:(CGSize)size
           backgroundColor:(UIColor *)backgroundColor
               borderColor:(UIColor *)borderColor
               borderWidth:(float)borderWidth
              cornerRadius:(float)cornerRadius;

- (UIImage *)imageTintedWithColor:(UIColor *)color
                         fraction:(CGFloat)fraction;

- (UIImage *)croppedImage:(CGRect)bounds;

- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;

- (CGAffineTransform)transformForOrientation:(CGSize)newSize;

@end
