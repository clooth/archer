//
//  ARColorMacros.h
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

#ifndef archer_ARColorMacros_h
#define archer_ARColorMacros_h

/**
 *  Create a transparent UIColor with a hex and alpha value
 *  Usage:
 *  UIColor *transparentRed   = colorFromRGBA(0xFF0000, 0.5);
 *  UIColor *transparentWhite = colorFromRGBA(0xFFFFFF, 0.5);
 */
#define colorFromRGBA(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:a]

/**
 *  Create a color from a given hex color
 *  Usage:
 *  UIColor *red   = colorFromRGB(0xFF0000);
 *  UIColor *white = colorFromRGB(0xFFFFFF);
 */
#define colorFromRGB(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:1.0]

#endif
