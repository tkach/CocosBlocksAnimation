//
// Created by Alexander Tkachenko on 12/25/13.
// Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//


#import "CBAEaseInOut.h"


@implementation CBAEaseInOut {

}

- (CGFloat)updateProgress:(CGFloat)progress {
    if (progress < 0.5f) {
        return 0.5f * powf (progress * 2, self.rate);
    }
    else {
        return 1.0f - 0.5f * powf(2-progress * 2, self.rate);
    }
}


@end