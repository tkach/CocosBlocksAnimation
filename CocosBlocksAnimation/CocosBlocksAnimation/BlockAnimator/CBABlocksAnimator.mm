//
// Created by Alexander Tkachenko on 12/18/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import "CBABlocksAnimator.h"
#import "CCDirector.h"
#import "CCNode.h"
#import "CCScene.h"
#import "CCTransition.h"
#import "CBABlockAnimationContext.h"
#import "CBABlockAnimationExecutor.h"
#import "CCNode+BlocksAnimatorPrivate.h"
#import "CCNode+BlocksAnimation.h"
#import "CBAEasingTimingFunction.h"


@interface CBABlocksAnimator ()

@property(nonatomic, retain) CBABlockAnimationExecutor * blockAnimationExecutor;

@end


@implementation CBABlocksAnimator {

}

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id shared = nil;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}


- (id)init {
    self = [super init];
    if (self) {
        self.blockAnimationExecutor = [[CBABlockAnimationExecutor new] autorelease];
    }

    return self;
}

#pragma mark - Public

- (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations timingBlock:(TimingFunctionBlock)timingBlock completion:(CompletionBlock)completion repeatCount:(int)repeatCount {
    [self animateWithDuration:duration animations:animations timingBlock:timingBlock timingFunction:nil completion:completion repeatCount:repeatCount];
}


- (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations timingFunction:(CBAEasingTimingFunction *)timingFunction completion:(CompletionBlock)completion repeatCount:(int)repeatCount {
    [self animateWithDuration:duration animations:animations timingBlock:nil timingFunction:timingFunction completion:completion repeatCount:repeatCount];
}


- (void)animateWithDuration:(NSTimeInterval)duration animations:(AnimationBlock)animations timingBlock:(TimingFunctionBlock)timingBlock timingFunction:(CBAEasingTimingFunction *)timingFunction completion:(CompletionBlock)completion repeatCount:(int)repeatCount {
    NSAssert(animations, @"CABlocksAnimator ERROR:"
     "\n        Please, provide non-nil AnimationsBlock"
    );

    // At first, take all nodes that are taking effect of animations
    NSArray *animatedNodes = [self animatedNodesForBlock:animations];
    NSAssert(animatedNodes.count, @"CABlocksAnimator ERROR:"
     "\n        It seems that animation block doesn't provide any animation. Maybe nodes aren't added to the node hierarchy yet?"
     "\n        Or you hadn't changed any animatable node properties in animation block"
    );

    //Create animation context
    CBABlockAnimationContext *context = [[CBABlockAnimationContext new] autorelease];
    context.animatedNodes = animatedNodes;
    context.duration = duration;
    context.completionBlock = completion;
    context.repeatCount = repeatCount;
    context.animations = animations;
    context.timingBlock = timingBlock;
    context.timingFunction = timingFunction;

    //and pass it for execution
    [self.blockAnimationExecutor addContextForExecution:context];
}


#pragma mark - Private utils

- (NSArray *)animatedNodesForBlock:(AnimationBlock)animations {
    NSMutableArray * animatedNodes = [NSMutableArray array];

    CCScene * sceneToCheck = [self getCurrentScene];

    [self saveCurrentStateInAllSubviews:sceneToCheck]; //saving current state to perform check if block animation will take effect

    animations();          //applying animations action immediately to check condition of changed nodes

    [self gatherAnimatedNodesStartingFrom:sceneToCheck toArray:animatedNodes];  //  gathering nodes with changed state - this nodes need to apply animations

    //cancel all nodes' animations and revert nodes states
    for (CCNode *node in animatedNodes) {
        [node cancelAllBlockAnimations];
        [node applySavedAnimatablePropertiesRepresentation];
    }

    return animatedNodes;
}


- (CCScene *)getCurrentScene {
    CCScene * scene = [CCDirector sharedDirector].runningScene;
    if ([scene isKindOfClass:[CCTransitionScene class]]) {
        CCTransitionScene * transitionScene = (CCTransitionScene *) scene;
        scene = [transitionScene valueForKey:@"_inScene"];
    }
    return scene;
}


- (void)saveCurrentStateInAllSubviews:(CCNode *)rootNode {
    [rootNode saveAnimatablePropertiesRepresentation];
    CCNode *node;
    CCARRAY_FOREACH(rootNode.children, node) {
            [self saveCurrentStateInAllSubviews:node];
        }
}


- (void)gatherAnimatedNodesStartingFrom:(CCNode *)rootNode toArray:(NSMutableArray *)array {
    if ([rootNode isSavedRepresentationDifferentFromCurrent]) {
        [array addObject:rootNode];
    }
    CCNode *node;
    CCARRAY_FOREACH(rootNode.children, node) {
            [self gatherAnimatedNodesStartingFrom:node toArray:array];
        }
}


- (void)cancelAllBlockAnimationsForNode:(CCNode *)node {
    [self.blockAnimationExecutor cancelAllAnimationsForNode:node];
}


@end