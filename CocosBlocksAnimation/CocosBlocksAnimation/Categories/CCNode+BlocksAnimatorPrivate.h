//
// Created by Alexander Tkachenko on 12/21/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CCNode.h"


@interface CCNode (BlocksAnimatorPrivate)


#pragma mark - BlocksAnimation helper
/**
* Saved properties state
*/
- (NSDictionary *)savedAnimatablePropertiesRepresentation;

/**
* Save current properties to state
*/
- (void)saveAnimatablePropertiesRepresentation;

/**
* Rollback to previous saved state
*/
- (void)applySavedAnimatablePropertiesRepresentation;

/**
* Get current state that is corresponding to node's position, rotation, etc
*/
- (NSDictionary *)animatablePropertiesRepresentation;

/**
* Checks is node's current state is changed from saved
*/
- (BOOL)isSavedRepresentationDifferentFromCurrent;

/**
* Applies given representation to node, changing it's position, rotation, etc
*/
- (void)applyRepresentation:(NSDictionary *)representation;


@end