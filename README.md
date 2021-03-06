CocosBlocksAnimation
====================

CocosBlocksAnimation is inspired by block-based UIView animation approach. 
  
  
  It allows you to create cocos2d animations easier — with the same approach as with UIView animations :
  
	[CCNode animateWithDuration:0.4f animations:^{
  		sprite1.scale = 2.0f;
  		sprite1.rotation = 180;
  		sprite2.scale = 1.5f;
  		sprite2.rotation = 90;
  	} completion:^{
  		NSLog("animation finished");
  	}
  	
  It's much simpler than using cocos2d animation system:
  
  	{
        CCScaleTo *action1 = [CCScaleTo actionWithDuration:0.4f scale:2];
        CCRotateTo *action2 = [CCRotateTo actionWithDuration:0.4f angle:180];
        CCFiniteTimeAction *actionSpawn = [CCSpawn actionOne:action1 two:action2];
        CCFiniteTimeAction *callBlock = [CCCallBlock actionWithBlock:^{
            NSLog(@"action completed");
        }];
        CCFiniteTimeAction *totalAction = [CCSequence actionOne:actionSpawn two:callBlock];
        [sprite1 runAction:totalAction];
    }

    {
        CCScaleTo *action1 = [CCScaleTo actionWithDuration:0.4f scale:1.5f];
        CCRotateTo *action2 = [CCRotateTo actionWithDuration:0.4f angle:90];
        CCFiniteTimeAction *actionSpawn = [CCSpawn actionOne:action1 two:action2];
        CCFiniteTimeAction *callBlock = [CCCallBlock actionWithBlock:^{
            NSLog(@"action completed");
        }];
        CCFiniteTimeAction *totalAction = [CCSequence actionOne:actionSpawn two:callBlock];
        [sprite2 runAction:totalAction];
    }
  
 Installation
============
If you are using CocoaPods ([https://github.com/CocoaPods/CocoaPods](https://github.com/CocoaPods/CocoaPods)), just include this line to your Podfile.

	pod 'CocosBlocksAnimation', :git => 'https://github.com/tkach/CocosBlocksAnimation.git'

Alternatively, you can just copy this directory in your project:

- CocosBlocksAnimation/CocosBlocksAnimation


Usage
=====
For using block-based animation, you need to import CocosBlocksAnimation header:
	
	#import "CCNode+BlocksAnimation.h"

Now you can use one of the methods included in CCNode+BlocksAnimation header. 
All of them take AnimationBlock as a parameter. 

You need to describe your animation in this block. 

It may transform multiple CCNode instances. All changed properties of all nodes grouped by AnimationBlock will be animated with the same animation duration.

Please, avoid any game logic in your AnimatinBlock, cause it's used internally in the engine. Operate only with nodes' properties. You may transform such animatable CCNode properties in AnimationBlock:

- position
- rotation
- scaleX, scaleY
- opacity (only in CCSprite subclasses)

Optionally you can provide CompletionBlock that will be called after animation finish. 

You can use predefined EasingFunctions: EaseIn, EaseOut, EaseInOut by using CBAEaseIn, CBAEaseOut, CBAEaseInOut timing functions and sending it as a parameter to 

	+ (void)animateWithDuration:(NSTimeInterval)duration 
				 	 animations:(AnimationBlock)animations 
				 	repeatCount:(NSInteger)repeatCount 
				 timingFunction:(CBAEasingTimingFunction *)timingFunction 
					 completion:(CompletionBlock)completion;



You may manipulate timing of the animation by providing your custom timing block, as in example below.


Example:

    - (void)runTestAnimation {
        [CCNode animateWithDuration:1.2f animations:^{
            [self rotateAndMoveToDistance:70];
        } repeatCount:3 timingBlock:^(CGFloat progress) {
            return progress * progress;
        }
            completion:^() {
                [CCNode animateWithDuration:1.2f animations:^{
                    [self rotateAndMoveToDistance:-210];
                }                completion:^() {
                    [self runTestAnimation];
                }];
            }
        ];
    }
    
    
    - (void)rotateAndMoveToDistance:(CGFloat)distance {
        self.container.rotation += 180;
    
        CCNode *node;
        CGFloat angle = 0;
        CCARRAY_FOREACH(self.container.children, node) {
                CGPoint dp = ccpMult(ccpForAngle(CC_DEGREES_TO_RADIANS(angle)), distance);
                node.position = ccpAdd(dp, node.position);
                angle+= 90;
     }


# ![Screenshot](https://raw.github.com/tkach/CocosBlocksAnimation/master/Demo.gif)


TODO
=====

Features planned sorted by priority (highest to lowest)

1. Easing functions support (EaseIn/Out, EaseSineIn/Out, Elastic, etc..)
2. Configurable delay before animations
3. Animations initialization optimization