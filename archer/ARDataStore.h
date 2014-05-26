//
//  ARDataStore.h
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//
#import <NanoStore/NanoStore.h>
#import "ARDataStoreModel.h"

extern NSString * const kARDataStoreExceptionName;

typedef NS_ENUM(NSUInteger, DataStoreOrderMode) {
    OrderModeAscending = 0,
    OrderModeDescending,
    OrderModeRandomized,
    OrderModeInvalid
};

@interface ARDataStore : NSFNanoStore

// Shared instance for data store
+ (ARDataStore *)sharedInstance;

// Shared instance for data store at path
+ (ARDataStore *)sharedInstanceWithStoreFilePath:(NSString *)storeFilePath;

// Shared instance for data store in memory
+ (ARDataStore *)sharedInstanceWithStoreInMemory;

// TODO: Object Finder
// TODO: Object Remover

@end
