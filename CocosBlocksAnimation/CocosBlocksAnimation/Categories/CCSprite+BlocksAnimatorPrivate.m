//
// Created by Alexander Tkachenko on 12/22/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import "CCSprite+BlocksAnimatorPrivate.h"


@implementation CCSprite (BlocksAnimatorPrivate)

- (NSArray *)ba_animatableProperties {
    return @[
     @"position",
     @"opacity",
     @"rotation",
     @"scaleX",
     @"scaleY",
     @"rotation",
    ];
}

@end