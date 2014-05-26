//
//  ARAppDelegateSpec.m
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright 2014 YouLapse Oy. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ARAppDelegate.h"
#import "ARAppDelegateService.h"

SPEC_BEGIN(ARAppDelegateSpec)

describe(@"ARAppDelegate", ^{
    __block ARAppDelegate *appDelegate = nil;

    beforeEach(^{
        appDelegate = [ARAppDelegate new];
    });

    context(@"Initializing AppDelegate", ^{
        [[appDelegate should] beMemberOfClass:[ARAppDelegate class]];
    });

    context(@"Initializing Services", ^{
        ARAppDelegateService *mockService = [ARAppDelegateService service];
        [appDelegate registerService:mockService];

        [[theValue([[appDelegate services] count]) should] equal:theValue(1)];
    });

});

SPEC_END
