//
//  ARAppDelegate.h
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

@import UIKit;

@class ARAppDelegateService;

@interface ARAppDelegate : UIResponder <UIApplicationDelegate>

#pragma mark - Properties

// An array of ARAppDelegateService objects
@property (strong, readonly)  NSArray  *services;

// The main UIWindow for the application
@property (strong, nonatomic) UIWindow *window;

#pragma mark - Methods

/**
 * Executes the given selector on all appropriate services
 *
 * @param argument A pointer to the argument to be passed along
 */
- (void)invokeServiceMethodWithSelector:(SEL)selector withArgument:(void *)argument;

/**
 * Registers a new service with the app delegate
 */
- (void)registerService:(ARAppDelegateService *)service;

@end
