//
//  ARDataStoreModel.h
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

#import "NSFNanoObject.h"

@interface ARDataStoreModel : NSFNanoObject

// When the model instance was created
@property (strong) NSDate *createdAt;

// Create a new empty model instance
+ (instancetype)model;

// Create a new model instance with given attributes
+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

// Create a new model instance with given attributes and a key to refer
// to the document storage.
+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary key:(NSString *)key;

@end
