//
// Created by Alexander Tkachenko on 12/18/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import "CCNode+BlocksAnimation.h"
#import "cocos2d.h"
#import "CBABlocksAnimator.h"

@implementation CCNode (BlocksAnimation)



#pragma mark - new

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations {
    [self animateWithDuration:duration animations:animations completion:nil];
}


+ (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations completion:(CompletionBlock)completion {
    [self animateWithDuration:duration animations:animations repeatCount:0 completion:completion];
}


+ (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations repeatCount:(NSInteger)repeatCount completion:(CompletionBlock)completion {
    [self animateWithDuration:duration animations:animations repeatCount:repeatCount timingBlock:nil completion:completion];
}


+ (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations repeatCount:(NSInteger)repeatCount timingBlock:(TimingFunctionBlock)timingBlock completion:(CompletionBlock)completion {
    [[CBABlocksAnimator sharedInstance] animateWithDuration:duration animations:animations timingBlock:timingBlock completion:completion repeatCount:repeatCount];
}


- (void)cancelAllBlockAnimations {
    [[CBABlocksAnimator sharedInstance] cancelAllBlockAnimationsForNode:self];
}


@end
