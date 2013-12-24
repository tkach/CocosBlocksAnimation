//
// Created by Alexander Tkachenko on 12/20/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import "CBABlockAnimationContext.h"
#import "CCNode.h"
#import "CCNode+BlocksAnimation.h"
#import "CGPointExtension.h"
#import "CCNode+BlocksAnimatorPrivate.h"
#import "CBAEasingTimingFunction.h"


@interface CBABlockAnimationContext ()

@property (nonatomic, strong) NSArray * finalNodeRepresentations;

@end

@implementation CBABlockAnimationContext {

}

#pragma mark - Public

- (void)startAction {
    /**
    *  Calculate final nodes representation
    *  */
    self.finalNodeRepresentations = [self calculateFinalRepresentations];
}


- (void)applyAnimationProgress:(CGFloat)progress {
    progress = progress > 1 ? 1 : progress;
    for (CCNode *node in self.animatedNodes) {
        NSDictionary *startRepresentation = node.savedAnimatablePropertiesRepresentation;
        NSDictionary *finalRepresentation = self.finalNodeRepresentations[[self.animatedNodes indexOfObject:node]];

        NSMutableDictionary *resultingRepresentation = [NSMutableDictionary dictionary];
        for (NSString *key in [startRepresentation allKeys]) {
            id  currentProgressValue = [self getCurrentProressValueForKey:key progress:progress startRepresentation:startRepresentation finalRepresentation:finalRepresentation];
            [resultingRepresentation setObject:currentProgressValue forKey:key];
        }
        [node applyRepresentation:resultingRepresentation];
    }
}


- (BOOL)isRunning {
    return self.finalNodeRepresentations != nil;
}



#pragma mark - Internal helpers
//progress -s [0..1]
- (id)getCurrentProressValueForKey:(NSString *)key progress:(CGFloat)progress startRepresentation:(NSDictionary *)startRepresentation finalRepresentation:(NSDictionary *)finalRepresentation {
    id currentProgressValue;
    id valueAtStart = startRepresentation[key];
    id valueFinal = finalRepresentation[key];

    if ([key isEqualToString:@"position"]) {
        CGPoint start = [valueAtStart CGPointValue];
        CGPoint end = [valueFinal CGPointValue];
        CGPoint diff = ccpSub(end, start);
        diff = ccpMult(diff, [self getValueAtProgress:progress]);
        CGPoint resultPoint = ccpAdd(start, diff);

        currentProgressValue = [NSValue valueWithCGPoint:resultPoint];
    }
    else {
        CGFloat start = [valueAtStart floatValue];
        CGFloat end = [valueFinal floatValue];
        CGFloat resultFloat = (CGFloat) (start + (end - start) * [self getValueAtProgress:progress]);
        currentProgressValue = @(resultFloat);
    }
    return currentProgressValue;
}


/**
* Gets value of variable at a given progress corresponding current timing function.
*/
- (CGFloat)getValueAtProgress:(CGFloat)progress {
    if (self.timingBlock) {
        return self.timingBlock(progress);
    }
    else if (self.timingFunction) {
        return [self.timingFunction updateProgress:progress];
    }
    else {
        return progress; //Linear
    }
}


- (NSArray * )calculateFinalRepresentations {
    for (CCNode *node in self.animatedNodes) {
        [node saveAnimatablePropertiesRepresentation];
    }
    self.animations();
    NSMutableArray * representations = [NSMutableArray array];
    for (CCNode *node in self.animatedNodes) {
        if (node.animatablePropertiesRepresentation) {
            [representations addObject:node.animatablePropertiesRepresentation];
            [node applySavedAnimatablePropertiesRepresentation];
        }
    }

    return representations;
}


- (void)removeNodeFromContext:(CCNode *)node {
    NSUInteger index = [self.animatedNodes indexOfObject:node];

    NSMutableArray *animatedNodesCopy = [[self.animatedNodes mutableCopy] autorelease];
    [animatedNodesCopy removeObjectAtIndex:index];
    self.animatedNodes = animatedNodesCopy;

    NSMutableArray *representationsCopy = [[self.finalNodeRepresentations mutableCopy] autorelease];
    [representationsCopy removeObjectAtIndex:index];
    self.finalNodeRepresentations = representationsCopy;
}


#pragma mark - Dealloc

- (void)dealloc {
    self.completionBlock = nil;
    self.animations = nil;
    self.timingBlock = nil;
    self.timingFunction = nil;
    [super dealloc];
}


@end