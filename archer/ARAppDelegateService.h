//
//  ARAppDelegateService.h
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

@import UIKit;

@interface ARAppDelegateService : NSObject <UIApplicationDelegate>

// Shared singleton for the service object
+ (ARAppDelegateService *)service;

@end
