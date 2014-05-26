//
//  ARDataStoreSpec.m
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright 2014 YouLapse Oy. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ARDataStore.h"
#import "ARDataStoreModel.h"

SPEC_BEGIN(ARDataStoreSpec)

describe(@"ARDataStore", ^{
    __block NSError *error = nil;

    context(@"Creating Objects", ^{
        // Initialize store
        ARDataStore *store = [ARDataStore sharedInstanceWithStoreInMemory];

        // Instantiate model object
        ARDataStoreModel *object = [ARDataStoreModel model];

        // Save model object to store
        [store addObject:object error:&error];
        [[error should] beNil];

        // Save store
        [store saveStoreAndReturnError:&error];
        [[error should] beNil];

        // Check parameters
        [[object.createdAt shouldNot] beNil];
    });

});

SPEC_END
