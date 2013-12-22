//
// Created by Alexander Tkachenko on 12/20/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CBABlockAnimationTypedefs.h"
@class CBABlockAnimationContext;
@class CCNode;


/**
* This class stores active contexts and performs animations.
*/
@interface CBABlockAnimationExecutor : NSObject

- (void)addContextForExecution:(CBABlockAnimationContext *)context;
- (void)cancelAllAnimationsForNode:(CCNode *)node;

@end