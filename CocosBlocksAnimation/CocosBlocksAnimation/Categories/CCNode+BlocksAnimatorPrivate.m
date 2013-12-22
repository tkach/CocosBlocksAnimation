//
// Created by Alexander Tkachenko on 12/21/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import "CCNode+BlocksAnimatorPrivate.h"
#import <objc/runtime.h>

@implementation CCNode (BlocksAnimatorPrivate)


static void * savedRepresentationKey = @"savedRepresentationKey";

#pragma mark - Helpers

- (NSArray *)ba_animatableProperties {
    return @[
     @"position",
     @"rotation",
     @"scaleX",
     @"scaleY",
     @"rotation",
    ];
}


- (void)applyRepresentation:(NSDictionary *)representation {
    for (NSString *propertyName in [representation allKeys]) {
        [self setValue:representation[propertyName] forKey:propertyName];
    }
}


- (NSDictionary *)savedAnimatablePropertiesRepresentation {
    return [self savedRepresentation];
}


- (void)saveAnimatablePropertiesRepresentation {
    NSDictionary * representation = [self animatablePropertiesRepresentation];
    [self setSavedRepresentation:representation];
}


- (void)applySavedAnimatablePropertiesRepresentation {
    NSDictionary * representation = [self savedRepresentation];
    [self applyRepresentation:representation];
}


- (NSDictionary *)animatablePropertiesRepresentation {
    NSMutableDictionary *values = [NSMutableDictionary dictionary];
    for (NSString *propertyName in [self ba_animatableProperties]) {
        [values setObject:[self valueForKey:propertyName] forKey:propertyName];
    }
    return values;
}


- (BOOL)isSavedRepresentationDifferentFromCurrent {
    NSDictionary * dictionary = [self savedAnimatablePropertiesRepresentation];
    NSDictionary * otherDictionary = [self animatablePropertiesRepresentation];
    BOOL isEqual = [dictionary isEqualToDictionary:otherDictionary];
    return !isEqual;
}


#pragma mark - Getters/Setters

- (void)setSavedRepresentation:(NSDictionary *)start {
    objc_setAssociatedObject(self, &savedRepresentationKey, start, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSDictionary *)savedRepresentation {
    return objc_getAssociatedObject(self, &savedRepresentationKey);
}


@end