//
//  ARGIFMaker.h
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

@import Foundation;

@interface ARGIFMaker : NSObject

#pragma mark - Properties

/**
 *  The number of times the GIF will loop (0 = infinite)
 */
@property (assign) NSUInteger loopCount;

/**
 *  The time in seconds that a single frame is displayed for
 */
@property (assign) CGFloat frameDelay;

/**
 *  The paths to the images that we want to make the GIF from
 */
@property (strong) NSArray *frameImagePaths;

/**
 *  The path we want to save the resulting GIF to
 */
@property (strong) NSString *saveFilePath;

/**
 *  The resolution we want the GIF to be, in pixels
 */
@property (assign) CGSize resolution;


#pragma mark - Methods

/**
 *  Start processing the images into the GIF animation
 *
 *  @return BOOL whether or not the process started successfully
 */
- (NSURL *)make;

@end
