//
//  ARDataStore.m
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

#import "ARDataStore.h"

NSString * const kARDataStoreExceptionName = @"ARDataStoreExceptionName";

@implementation ARDataStore

#pragma mark - Initializers

static ARDataStore *sharedInstance = nil;

+ (ARDataStore *)sharedInstanceWithStoreFilePath:(NSString *)storeFilePath
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithStoreFilePath:storeFilePath];
    });
    return sharedInstance;
}

+ (ARDataStore *)sharedInstanceWithStoreInMemory
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithStoreInMemory];
    });
    return sharedInstance;
}

+ (ARDataStore *)sharedInstance
{
    if (sharedInstance == nil) {
        NSLog(@"%@ warning sharedInstance called before sharedInstanceWithStoreFilePath:", self);
    }

    return sharedInstance;
}

- (instancetype)initWithStoreFilePath:(NSString *)storeFilePath
{
    return [self initWithStoreType:NSFPersistentStoreType atPath:storeFilePath];
}

- (instancetype)initWithStoreInMemory
{
    return [self initWithStoreType:NSFMemoryStoreType atPath:nil];
}

- (instancetype)initWithStoreType:(NSFNanoStoreType)storeType atPath:(NSString *)storePath
{
    // Create data store with path
    if (!(self = [super initStoreWithType:storeType path:storePath])) {
        return nil;
    }

    [self setupStoreAttributes];

    return self;
}

- (void)setupStoreAttributes
{
    // Initialize parameters for store
    NSFNanoEngine *nanoStoreEngine = [self nanoStoreEngine];

    // Set the synchronous mode setting
    [nanoStoreEngine setSynchronousMode:SynchronousModeNormal];
    [nanoStoreEngine setEncodingType:NSFEncodingUTF8];

    NSError *nanoStoreError = nil;
    [self openWithError:&nanoStoreError];

    // If any errors
    if (nanoStoreError != nil) {
        [NSException exceptionWithName:kARDataStoreExceptionName
                                reason:@"Failed to initialize ARDataStore."
                              userInfo:nanoStoreError.userInfo];
    }
}

@end
