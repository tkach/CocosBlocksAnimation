//
//  CCBABlockAnimationTypedefs.h
//  Cocos2dBlocksAnimation
//
//  Created by Alexander Tkachenko on 12/20/13.
//  Copyright (c) 2013 Alexander Tkachenko. All rights reserved.
//

#ifndef Cocos2dBlocksAnimation_CCBABlockAnimationTypedefs____FILEEXTENSION___
#define Cocos2dBlocksAnimation_CCBABlockAnimationTypedefs____FILEEXTENSION___

typedef void (^CompletionBlock)();
typedef void (^AnimationBlock)();
typedef CGFloat (^TimingFunctionBlock)(CGFloat progress); // Custom timing function — takes progress [0, 1] => returns value coefficient [0, 1]

typedef NS_ENUM(NSInteger, CBATimingFunctionType) {
    BATimingFunctionTypeLinear,
    BATimingFunctionTypeEaseIn,
    BATimingFunctionTypeEaseOut,
    BATimingFunctionTypeEaseInOut,
};

#endif
