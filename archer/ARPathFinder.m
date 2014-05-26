//
//  ARPathFinder.m
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

#import "ARPathFinder.h"

NSString * const kARPFCachedDocumentsPathKey = @"ARPFCachedDocumentsPathKey";

@implementation ARPathFinder

#pragma mark - Paths

+ (NSString *)documentsPath
{
    NSString *cachedPath = [self getCacheObjectForKey:kARPFCachedDocumentsPathKey];
    if (cachedPath != nil) {
        return cachedPath;
    }

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    [self setCacheObject:paths[0] forKey:kARPFCachedDocumentsPathKey];

    return paths[0];
}

#pragma mark - Cache

+ (id)getCacheObjectForKey:(NSString *)cacheObjectKey
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    id object = [threadDictionary objectForKey:cacheObjectKey];

    return (!object) ? nil : object;
}

+ (void)setCacheObject:(id)object forKey:(NSString *)cacheObjectKey
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    [threadDictionary setObject:object forKey:cacheObjectKey];
}

@end
