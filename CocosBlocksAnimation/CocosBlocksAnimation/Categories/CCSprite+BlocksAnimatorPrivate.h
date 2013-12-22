//
// Created by Alexander Tkachenko on 12/22/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <cocos2d/CCSprite.h>


@interface CCSprite (BlocksAnimatorPrivate)

/**
* Used by BlocksAnimator to gather animatable properties for this class
*/
- (NSArray *)ba_animatableProperties;

@end