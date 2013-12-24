//
// Created by Alexander Tkachenko on 12/20/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CBABlockAnimationTypedefs.h"

@class CCNode;
@class CBAEasingTimingFunction;


@interface CBABlockAnimationContext : NSObject

@property (nonatomic, strong) NSArray * animatedNodes;

@property(nonatomic) NSTimeInterval duration;
@property (nonatomic) NSTimeInterval elapsedTime;
@property (nonatomic) NSInteger repeatCount;

@property(nonatomic, copy) CompletionBlock completionBlock;
@property(nonatomic, copy) AnimationBlock animations;
@property(nonatomic, readonly) BOOL isRunning;

@property(nonatomic, copy) TimingFunctionBlock timingBlock;
@property(nonatomic, retain) CBAEasingTimingFunction * timingFunction;

- (void)applyAnimationProgress:(CGFloat)progress;
- (void)startAction;

- (void)removeNodeFromContext:(CCNode *)node;
@end