//
// Created by Alexander Tkachenko on 12/25/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface CBAEasingTimingFunction : NSObject

/**
* Behaves as Linear by default, should be overriden in subclasses
*/
- (CGFloat)updateProgress:(CGFloat)progress;

@end