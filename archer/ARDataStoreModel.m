//
//  ARDataStoreModel.m
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

#import "ARDataStoreModel.h"
#import <objc/runtime.h>

void * ARDSModelBagsKey = &ARDSModelBagsKey;

NSString* keyWithSetterName(NSString * setter) {
    NSUInteger setterLength = setter.length;
    if (setterLength >= 5) {
        NSMutableString *key = [NSMutableString string];
        [key appendString:[setter substringWithRange:NSMakeRange(3, 1)].lowercaseString];
        [key appendString:[setter substringWithRange:NSMakeRange(4, setterLength - 5)]];
        return key;
    }
    else {
        [NSException raise:NSInvalidArgumentException
                    format:@"setter name should be at least 5 characters long"];
        return nil;
    }
};

// Implementation of attribute setter (set<AttributeName>:)
void ARDSModelAttributeSetter(id self, SEL _cmd, id val) {
    ARDataStoreModel* object = self;
    NSString* selector       = NSStringFromSelector(_cmd);
    NSString* key            = keyWithSetterName(selector);

    [self willChangeValueForKey:key];

    if (val) {
        [object setObject:val forKey:key];
    } else {
        [object removeObjectForKey:key];
    }

    [self didChangeValueForKey:key];
}

// Implementation of attribute getter (<AttributeName>)
id ARDSModelAttributeGetter(id self, SEL _cmd) {
    ARDataStoreModel* object = self;
    NSString *key            = NSStringFromSelector(_cmd);

    return [object objectForKey:key];
}

// Implementation of bag getter (<AttributeName>)
id ARDSModelBagGetter(id self, SEL _cmd) {
    ARDataStoreModel* object = self;
    NSString* key            = NSStringFromSelector(_cmd);
    NSString* bagKey         = [object objectForKey:key];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

    if (bagKey) {
        NSFNanoBag* bag = [[object performSelector:@selector(ardsBags)] objectForKey:key];
        if (bag) {
            return bag;
        }

        NSArray* bags = [[object store] bagsWithKeysInArray:@[bagKey]];
        if ([bags count] > 0) {
            return [bags objectAtIndex:0];
        }
    }

#pragma clang diagnostic pop

    return nil;
}

// Implementation of bag setter (set<AttributeName>:)
void ARDSModelBagSetter(id self, SEL _cmd, id val) {
    NSAssert([[val class] isSubclassOfClass:[NSFNanoBag class]], @"value must be a NSFNanoBag");

    ARDataStoreModel* object = self;
    NSFNanoBag* bag          = val;
    NSString* selector       = NSStringFromSelector(_cmd);
    NSString* key            = keyWithSetterName(selector);

    [self willChangeValueForKey:key];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

    if (val) {
        [object setObject:bag.key forKey:key];
        [[object performSelector:@selector(ardsBags)] setObject:bag forKey:key];
    } else {
        [object removeObjectForKey:key];
        [[object performSelector:@selector(ardsBags)] removeObjectForKey:key];
    }

#pragma clang diagnostic pop

    [self didChangeValueForKey:key];
}

@interface ARDataStoreModel ()

- (NSMutableDictionary *)ardsBags;

@end

@implementation ARDataStoreModel

@dynamic createdAt;

- (NSMutableDictionary *)ardsBags
{
    NSMutableDictionary* bags = (NSMutableDictionary *)objc_getAssociatedObject([self class],
                                                                                &ARDSModelBagsKey);
    if (!bags) {
        bags = [NSMutableDictionary dictionary];
        objc_setAssociatedObject([self class],
                                 &ARDSModelBagsKey,
                                 bags,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    return bags;
}

+ (void)setupAccessors
{
    // Supported property types
    NSSet* supportedType = [NSSet setWithArray:@[[NSArray class],
                                                 [NSDictionary class],
                                                 [NSString class],
                                                 [NSData class],
                                                 [NSDate class],
                                                 [NSNumber class]]];

    //
    NSRegularExpression* typeExpr = [NSRegularExpression regularExpressionWithPattern:@"T@\"([a-zA-Z]+)\""
                                                                              options:0
                                                                                error:nil];

    // iterate all properties
    unsigned int numberOfProperties = 0;
    objc_property_t* propertyArray = class_copyPropertyList([self class], &numberOfProperties);
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString* attribute = [[NSString alloc] initWithUTF8String:property_getName(property)];
        NSString* attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        NSTextCheckingResult* firstMatch;
        if ((firstMatch = [typeExpr firstMatchInString:attributesString
                                               options:0
                                                 range:NSMakeRange(0, attributesString.length)])) {

            NSRange range = [firstMatch rangeAtIndex:1];
            NSString* clazzName = [attributesString substringWithRange:range];
            Class clazz = NSClassFromString(clazzName);

            // for each supported property type
            [supportedType enumerateObjectsUsingBlock:^(Class supportedClazz, BOOL *stop) {
                if ([clazz isSubclassOfClass:supportedClazz]) {
                    NSString *setterName = [NSString stringWithFormat:@"set%@%@:", [[attribute substringWithRange:NSMakeRange(0, 1)] uppercaseString], [attribute substringWithRange:NSMakeRange(1, attribute.length-1)]];
                    class_addMethod([self class], NSSelectorFromString(setterName), (IMP) ARDSModelAttributeSetter, "v@:@");
                    class_addMethod([self class], NSSelectorFromString(attribute), (IMP) ARDSModelAttributeGetter, "@@:");
                    *stop = YES;
                }
            }];

            // for Bag
            if ([clazz isSubclassOfClass:[NSFNanoBag class]] || [clazzName isEqualToString:@"NSFNanoBag"]) {
                NSString *setterName = [NSString stringWithFormat:@"set%@%@:", [[attribute substringWithRange:NSMakeRange(0, 1)] uppercaseString], [attribute substringWithRange:NSMakeRange(1, attribute.length-1)]];
                class_addMethod([self class], NSSelectorFromString(setterName), (IMP)ARDSModelBagSetter, "v@:@");
                class_addMethod([self class], NSSelectorFromString(attribute), (IMP)ARDSModelBagGetter, "@@:");
            }
        }
    }
    free(propertyArray);
}

+ (void)initialize
{
    [self setupAccessors];
}

+ (instancetype)model
{
    ARDataStoreModel *instance = [[self alloc] initNanoObjectFromDictionaryRepresentation:nil
                                                                                   forKey:nil
                                                                                    store:nil];
    instance.createdAt = [NSDate date];

    return instance;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    ARDataStoreModel *instance = [[self alloc] initNanoObjectFromDictionaryRepresentation:dictionary
                                                                                   forKey:nil
                                                                                    store:nil];
    instance.createdAt = [NSDate date];

    return instance;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary key:(NSString *)key
{
    ARDataStoreModel *instance = [[self alloc] initNanoObjectFromDictionaryRepresentation:dictionary
                                                                                   forKey:key
                                                                                    store:nil];
    instance.createdAt = [NSDate date];

    return instance;
}


@end
