//
//  ARGIFMaker.m
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

@import ImageIO;
@import MobileCoreServices;

// Archer Libraries
#import "ARGIFMaker.h"
#import "ARPathFinder.h"
#import "ARRandomizer.h"

// Extensions
#import "UIImage+ARExtensions.h"

@interface ARGIFMaker ()

@property (strong) NSDictionary *imageProperties;
@property (strong) NSDictionary *frameProperties;

@property (strong) UIImageView  *renderingView;

@end

@implementation ARGIFMaker

- (instancetype)init
{
    if (!(self = [super init])) return nil;

    _resolution = CGSizeMake(240, 240); // small-ish
    _frameDelay = (1.0 / 24.0); // 24fps
    _loopCount  = 0;

    // Random file name by default
    NSString *randomFileName = [ARRandomizer randomFileNameWithExtension:@"gif"];
    _saveFilePath = [[ARPathFinder documentsPath] stringByAppendingPathComponent:randomFileName];

    return self;
}

- (NSURL *)make
{
    // Bail if no images
    if (_frameImagePaths.count <= 0) {
        return NO;
    }

    [self setupProperties];
    [self setupRenderingView];

    CGImageDestinationRef imageDestination = CGImageDestinationCreateWithURL(
        (__bridge CFURLRef)[NSURL fileURLWithPath:_saveFilePath],
        kUTTypeGIF,
        _frameImagePaths.count,
        NULL
    );
    CGImageDestinationSetProperties(imageDestination, (__bridge CFDictionaryRef)_imageProperties);


    for (NSString *imagePath in _frameImagePaths) {
        @autoreleasepool {
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
            if (image != nil) {
                [_renderingView setImage:image];
                UIImage *frameImage = [UIImage imageWithView:_renderingView];
                CGImageDestinationAddImage(
                    imageDestination,
                    frameImage.CGImage,
                    (__bridge CFDictionaryRef)_frameProperties
                );
                frameImage = nil;
            }
        }
    }

    if (!CGImageDestinationFinalize(imageDestination)) {
        NSLog(@"ARGIFMaker: Failed to create GIF.");
    }

    if (imageDestination != NULL) {
        CFRelease(imageDestination);
    }

    return [NSURL fileURLWithPath:_saveFilePath];
}

- (void)setupProperties
{
    _imageProperties = @{(__bridge id)kCGImagePropertyGIFDictionary: @{
                                 (__bridge id)kCGImagePropertyGIFLoopCount: @(_loopCount)}
                         };

    _frameProperties = @{(__bridge id)kCGImagePropertyGIFDictionary: @{
                                 (__bridge id)kCGImagePropertyGIFDelayTime: @(_frameDelay)
                                 }};
}

- (void)setupRenderingView
{
    CGRect renderingViewRect = CGRectMake(0, 0, _resolution.width, _resolution.height);
    _renderingView = [[UIImageView alloc] initWithFrame:renderingViewRect];
    [_renderingView setBackgroundColor:colorFromRGB(0x000000)];
    [_renderingView setContentMode:UIViewContentModeScaleAspectFit];
}

@end
