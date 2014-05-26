//
//  ARAppDelegateService.m
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

#import "ARAppDelegateService.h"

// Service instance storage dictionaries
static NSMutableDictionary *sharedDispatchPredicates = nil;
static NSMutableDictionary *sharedInstances = nil;

// Predicates for instances
static dispatch_once_t predicateDictionaryPredicate;
static dispatch_once_t instanceDictionaryPredicate;

// Implementation
@implementation ARAppDelegateService

/**
 * Returns a shared dictionary singleton used to store addresses of dispatch_once_t predicates
 * This allows for a per-class type dispatch_once
 */
+ (NSMutableDictionary *)sharedDispatchPredicates
{
    dispatch_once(&predicateDictionaryPredicate, ^{
        // Ensure we don't overwrite a manually set shared instance (useful in testing)
        if (sharedDispatchPredicates != nil) return;

        sharedDispatchPredicates = [[NSMutableDictionary alloc] init];
    });

    return sharedDispatchPredicates;
}

/**
 * Accessor for all the shared instances of services
 */
+ (NSMutableDictionary *)sharedInstances
{
    dispatch_once(&instanceDictionaryPredicate, ^{
        // Ensure we don't overwrite a manually set shared instance (useful in testing)
        if (sharedInstances != nil) return;

        sharedInstances = [[NSMutableDictionary alloc] init];
    });

    return sharedInstances;
}

/**
 * Find the correct service object and return its shared instance
 */
+ (ARAppDelegateService *)service
{
    NSMutableDictionary *predicates = [self sharedDispatchPredicates];
    NSMutableDictionary *instances = [self sharedInstances];

    NSString *classString = NSStringFromClass([self class]);

    dispatch_once_t *pred;
    NSNumber *predicateAddress;

    if ([[predicates allKeys] containsObject:classString])
    {
        predicateAddress = [predicates valueForKey:classString];
        NSUInteger address = [predicateAddress unsignedIntegerValue];

        pred = (dispatch_once_t *)address;
    }
    else
    {
        // This class instance does not have a
        // Allocate new memory for this instance of pred
        pred = (long *)malloc(sizeof(long));
        *pred = 0;

        predicateAddress = [NSNumber numberWithUnsignedInteger:(NSUInteger)pred];

        [predicates setValue:predicateAddress forKey:classString];
    }

    dispatch_once(pred, ^{
        // Ensure we don't overwrite a manually set shared instance (useful in testing)
        id service = [instances valueForKey:classString];

        if (service) return;

        service = [[[self class] alloc] init];

        [instances setValue:service forKey:classString];
    });

    return [instances valueForKey:classString];
}

@end
