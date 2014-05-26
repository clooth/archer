//
//  ARNavigationController.h
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

@import UIKit;

typedef void(^ARNavigationCodeBlock)(void);

@interface ARNavigationController : UINavigationController <UINavigationControllerDelegate>

- (void)pushCodeBlock:(ARNavigationCodeBlock)codeBlock;
- (void)runNextCodeBlock;

@property (strong) NSMutableArray *codeBlockStack;
@property (assign) BOOL isTransitioning;

@end
