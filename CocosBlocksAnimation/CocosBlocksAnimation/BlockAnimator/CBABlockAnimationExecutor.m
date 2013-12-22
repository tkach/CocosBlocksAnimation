//
// Created by Alexander Tkachenko on 12/20/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import "CBABlockAnimationExecutor.h"
#import "ccTypes.h"
#import "cocos2d.h"
#import "CBABlockAnimationContext.h"

@interface CBABlockAnimationExecutor ()

@property (nonatomic, strong) NSMutableArray * animationContexts;

@end


@implementation CBABlockAnimationExecutor {

}

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        self.animationContexts = [NSMutableArray array];
        [[CCDirector sharedDirector].scheduler scheduleUpdateForTarget:self
                                                              priority:0
                                                                paused:NO];
    }
    return self;
}


#pragma mark - Public

- (void)addContextForExecution:(CBABlockAnimationContext *)context {
    [self.animationContexts addObject:context];
    if (!context.isRunning) {
        [context startAction];
    }
}


#pragma mark - Update

- (void)update:(ccTime)timeDelta {
    for (CBABlockAnimationContext * context in self.animationContexts) {
        context.elapsedTime += timeDelta;
        CGFloat progress = (float)(context.elapsedTime / context.duration);
        [self updateAction:context toProgress:progress];
    }
}


- (void)updateAction:(CBABlockAnimationContext *)context toProgress:(CGFloat)progress {
    [context applyAnimationProgress:progress];

    if (progress >= 1) {
        context.repeatCount--;
        if (context.repeatCount > 0) {
            context.elapsedTime = 0;
            [context startAction];
        }
        else {
            [context retain];
            [self.animationContexts removeObject:context];
            if (context.completionBlock) {
                context.completionBlock();
            }
            [context release];
        }
    }
}


- (void)cancelAllAnimationsForNode:(CCNode *)node {
    for (CBABlockAnimationContext * context in self.animationContexts) {
        if ([context.animatedNodes containsObject:node]) {
            [context removeNodeFromContext:node];

            if (context.animatedNodes.count == 0) {
                [self.animationContexts removeObject:context];
            }
        }
    }
}

@end
