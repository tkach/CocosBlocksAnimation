//
// Created by Alexander Tkachenko on 12/18/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CBABlockAnimationTypedefs.h"

@class CCNode;
@class CBABlockAnimationExecutor;

@interface CBABlocksAnimator : NSObject

/**
* Provides shared instance of blocks animator
*/
+ (instancetype)sharedInstance;

/**
* Please, use  only animatable properties from this list in AnimationBlock:
* - position
* - rotation
* - scaleX
* - scaleY
*
* Please, don't put any game logic in AnimationBlock, cause it's used internally and such usage has unpredicted behavior
*/
- (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations timingBlock:(TimingFunctionBlock)timingBlock completion:(CompletionBlock)completion repeatCount:(int)repeatCount;

/**
* Cancelling all animations for node
*/
- (void)cancelAllBlockAnimationsForNode:(CCNode *)node;

@end