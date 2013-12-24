//
// Created by Alexander Tkachenko on 12/25/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import "CBAEaseIn.h"


@implementation CBAEaseIn {

}

+ (instancetype)functionWithRate:(CGFloat)rate {
    return [[[self alloc] initWithRate:rate] autorelease];
}


- (instancetype)initWithRate:(CGFloat)rate {
    self = [super init];
    if (self) {
        self.rate = rate;
    }
    return self;
}


- (CGFloat)updateProgress:(CGFloat)progress {
    return powf(progress, self.rate);
}

@end