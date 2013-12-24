//
// Created by Alexander Tkachenko on 12/25/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CBAEasingTimingFunction.h"


@interface CBAEaseIn : CBAEasingTimingFunction

@property(nonatomic) CGFloat rate;

+ (instancetype)functionWithRate:(CGFloat)rate;
- (instancetype)initWithRate:(CGFloat)rate;

@end