//
//  ARColorMacrosSpec.m
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright 2014 YouLapse Oy. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ARColorMacros.h"

SPEC_BEGIN(ARColorMacrosSpec)

void(^testColorEquality) (UIColor*, UIColor*) = ^void(UIColor *color, UIColor *otherColor) {
    CGFloat red, green, blue, alpha;
    CGFloat red2, green2, blue2, alpha2;

    [color       getRed:&red  green:&green  blue:&blue  alpha:&alpha];
    [otherColor  getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];

    [[theValue(red) should] equal:theValue(red2)];
    [[theValue(green) should] equal:theValue(green2)];
    [[theValue(blue) should] equal:theValue(blue2)];
    [[theValue(alpha) should] equal:theValue(alpha2)];
};

describe(@"ARColorMacros", ^{


    it(@"colorFromRGBA", ^{
        UIColor *nativeRedColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
        UIColor *macroRedColor  = colorFromRGBA(0xff0000, 0.5);

        testColorEquality(nativeRedColor, macroRedColor);
    });

    it(@"colorFromRGB", ^{
        UIColor *nativeRedColor = [UIColor redColor];
        UIColor *macroRedColor  = colorFromRGB(0xff0000);

        testColorEquality(nativeRedColor, macroRedColor);
    });


});

SPEC_END
