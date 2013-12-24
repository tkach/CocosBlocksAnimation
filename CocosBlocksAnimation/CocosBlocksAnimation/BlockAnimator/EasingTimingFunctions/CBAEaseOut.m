//
// Created by Alexander Tkachenko on 12/25/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import "CBAEaseOut.h"


@implementation CBAEaseOut {

}

- (CGFloat)updateProgress:(CGFloat)progress {
    return powf(progress, 1 / self.rate);
}


@end