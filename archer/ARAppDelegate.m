//
//  ARAppDelegate.m
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

#import "ARAppDelegate.h"
#import "ARAppDelegateService.h"
#import "RTProtocol.h"
#import "RTMethod.h"

@implementation ARAppDelegate
{
    // Internal mutable storage for the services registered
    // with this application delegate
    NSMutableArray *_services;
}

#pragma mark - Service registration

- (void)registerService:(ARAppDelegateService *)service
{
    // If no service object is provided or it's already registered,
    // don't do anything.
    if (!service || [_services containsObject:service])
    {
        return;
    }
    // Add it to the services storage
    else
    {
        [_services addObject:service];
    }
}

- (NSArray *)services
{
    return _services;
}

- (void)invokeServiceMethodWithSelector:(SEL)selector withArgument:(void*)argument
{
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];

    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    [invocation setArgument:argument atIndex:2];

    [self invokeInvocationOnServices:invocation];
}

#pragma mark - App Delegate Lifecycle

/**
 * Initializes a new service oriented app delegate
 */
- (id)init
{
    if (!(self = [super init])) return nil;

    _services = [[NSMutableArray alloc] init];

    return self;
}

/**
 * Responds with YES to all selectors in the UIApplicationDelegate protocol since we want to forward them to
 * our service objects. If the UIApplicationDelegate does not implement the given selector as an optional instance
 * method, check if the superclass responds to the selector
 *
 *
 * @param aSelector The selector to check this classes response to
 */
- (BOOL)respondsToSelector:(SEL)aSelector
{
    RTProtocol *protocol = [RTProtocol protocolWithName:@"UIApplicationDelegate"];
    NSArray *methods = [protocol methodsRequired:NO instance:YES];

    for (RTMethod *method in methods)
    {
        if ([method selector] == aSelector)
        {
            return YES;
        }
    }

    return [super respondsToSelector:aSelector];
}


/**
 * Attempts to forward NSInvocations to each of the service objects
 *
 * This method gets called when this class responds to a selector that is not implemented
 *
 * @param anInvocation the invocation to forward
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [self invokeInvocationOnServices:anInvocation];
}


/**
 * Invokes the given invocation on each service if it responds
 *
 * @param invocation The invocation to attempt to run on each service
 */
- (void)invokeInvocationOnServices:(NSInvocation *)invocation
{
    for (ARAppDelegateService *service in _services)
    {
        if ([service respondsToSelector:[invocation selector]])
        {
            [invocation performSelector:@selector(invokeWithTarget:)
                               onThread:[NSThread currentThread]
                             withObject:service
                          waitUntilDone:YES];
        }
    }
}

@end
