//
//  ARNavigationController.m
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

#import "ARNavigationController.h"

@interface ARNavigationController ()

@end

@implementation ARNavigationController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.delegate = self;
    self.codeBlockStack = [NSMutableArray array];
}

#pragma mark - View Controller Configuration

// Configuration for view controllers that are being
- (void)viewControllerWillShow:(UIViewController *)viewController
{
    NSLog(@"Will show view controller %@", NSStringFromClass([viewController class]));
}

#pragma mark - Navigation methods

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
{
    @synchronized(self.codeBlockStack)
    {
        // Add to stack if we're transitioning
        if (self.isTransitioning == YES) {
            // Add push action to the current stack
            ARNavigationCodeBlock codeBlock = [^{
                [super pushViewController:viewController animated:animated];
            } copy];
            [self.codeBlockStack addObject:codeBlock];
        }
        // If not transitioning
        else {
            [super pushViewController:viewController animated:animated];
        }
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    @synchronized(self.codeBlockStack)
    {
        // Add to stack if we're transitioning
        if (self.isTransitioning == YES) {
            // Add pop action to the current stack
            ARNavigationCodeBlock codeBlock = [^{
                [super popViewControllerAnimated:animated];
            } copy];
            [self.codeBlockStack addObject:codeBlock];

            return nil;
        }
        // If not transitioning
        else {
            return [super popViewControllerAnimated:animated];
        }
    }
}

- (UIViewController *)popViewController
{
    return [self popViewControllerAnimated:YES];
}

- (void)setViewControllers:(NSArray *)viewControllers
                  animated:(BOOL)animated
{
    @synchronized(self.codeBlockStack)
    {
        // Add to stack if transitioning
        if (self.isTransitioning == YES) {
            ARNavigationCodeBlock codeBlock = [^{
                [super setViewControllers:viewControllers animated:animated];
            } copy];
            [self.codeBlockStack addObject:codeBlock];
        }
        // If not transitioning
        else {
            [super setViewControllers:viewControllers animated:animated];
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    @synchronized(self.codeBlockStack)
    {
        self.isTransitioning = true;

        [self viewControllerWillShow:viewController];
    }
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    @synchronized(self.codeBlockStack)
    {
        self.isTransitioning = false;

        [self runNextCodeBlock];
    }
}

#pragma mark - Code block stack

- (void)pushCodeBlock:(ARNavigationCodeBlock)codeBlock {
    @synchronized(self.codeBlockStack)
    {
        // Add it to the stack
        [self.codeBlockStack addObject:[codeBlock copy]];

        // Run it instantly if we're not transitioning
        if (!self.isTransitioning)
            [self runNextCodeBlock];
    }
}

- (void)runNextCodeBlock
{
    // Do nothing if we're out of stack objects
    if (self.codeBlockStack.count == 0)
        return;

    // Get the first one
    ARNavigationCodeBlock topBlock = [self.codeBlockStack objectAtIndex:0];

    // Execute block, then remove it from the stack (which will dealloc)
    topBlock();

    [self.codeBlockStack removeObjectAtIndex:0];
}

#pragma mark - Auto Rotation

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

@end
