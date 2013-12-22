//
// Created by Alexander Tkachenko on 12/18/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CCNode.h"
#import "CBABlockAnimationTypedefs.h"


@interface CCNode (BlocksAnimation)

#pragma mark - Animation interface

/**
* This methods provide an easier way to perform animations on CCNodes than standard Cocos2d actions mechanism.
* Animatable properties are:
* - position
* - rotation
* - scaleX
* - scaleY
* - opacity (only in CCSprite and its subclasses)
*
* Please, don't put any game logic in AnimationBlock,
* cause it's used internally and such usage has unpredicted behavior.
* Use CompletionBlock to perform some action at the end of an animation.
*/

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations;

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations completion:(CompletionBlock)completion;

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations repeatCount:(NSInteger)repeatCount completion:(CompletionBlock)completion;

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations repeatCount:(NSInteger)repeatCount timingBlock:(TimingFunctionBlock)timingBlock completion:(CompletionBlock)completion;

//TODO: + (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations repeatCount:(NSInteger)repeatCount timingFunction:(BATimingFunctionType)timingFunctionType completion:(CompletionBlock)completion;

- (void)cancelAllBlockAnimations;

@end