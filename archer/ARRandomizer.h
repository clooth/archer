//
//  ARRandomGenerator.h
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARRandomizer : NSObject

#pragma mark - Strings

+ (NSString *)randomStringWithLength:(NSUInteger)length;

#pragma mark - File names

+ (NSString *)randomFileNameWithExtension:(NSString *)extension;

#pragma mark - Names

+ (NSString *)randomName;

#pragma mark - Numbers

+ (NSUInteger)randomIntegerBetween:(NSUInteger)from and:(NSUInteger)to;
+ (CGFloat)randomFloatBetween:(CGFloat)from and:(CGFloat)to;

#pragma mark - Colors

+ (UIColor *)randomColor;

@end
