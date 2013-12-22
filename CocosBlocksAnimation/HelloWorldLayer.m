//
//  HelloWorldLayer.m
//  Cocos2dBlocksAnimation
//
//  Created by Alexander Tkachenko on 12/18/13.
//  Copyright Alexander Tkachenko 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "CCNode+BlocksAnimation.h"

#pragma mark - HelloWorldLayer

@interface HelloWorldLayer ()
@property(nonatomic, retain) CCLabelTTF * label;
@property(nonatomic, retain) CCNode * container;
@end


// HelloWorldLayer implementation
@implementation HelloWorldLayer {
    CGSize _winSize;
}

#pragma mark - Init

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        _winSize = [CCDirector sharedDirector].winSize;

        self.container = [CCNode node];
        self.container.position = ccp(_winSize.width / 2, _winSize.height / 2);
        [self addChild:self.container];

        for (int i = 0; i < 4; i++) {
            CCSprite *icon = [CCSprite spriteWithFile:@"Icon.png"];
            [self.container addChild:icon];
        }
	}
	return self;
}


- (void)onEnterTransitionDidFinish {
    [super onEnterTransitionDidFinish];

    [self runTestAnimation];
}


#pragma mark - Animations

- (void)runTestAnimation {
    [CCNode animateWithDuration:0.4f animations:^{
        [self rotateAndMoveToDistance:70];
    } repeatCount:3 timingBlock:^(CGFloat progress) {
        return progress * progress;
    }
        completion:^() {
            [CCNode animateWithDuration:0.5f animations:^{
                [self rotateAndMoveToDistance:-210];
            }                completion:^() {
                [self runTestAnimation];
            }];
        }
    ];
}


- (void)rotateAndMoveToDistance:(CGFloat)distance {
    self.container.rotation += 180;
    CGFloat angle = 0;
    CCNode *node;
    CCARRAY_FOREACH(self.container.children, node) {
            CGPoint dp = ccpMult(ccpForAngle(CC_DEGREES_TO_RADIANS(angle)), distance);
            node.position = ccpAdd(dp, node.position);
            if ([node isKindOfClass:[CCSprite class]]) {
                CCSprite * sprite = (CCSprite *) node;
            }
            angle+= 90;
            };
}


- (void)cancelAnimationsForNode:(id)node {
    [node cancelAllBlockAnimations];
}


#pragma mark - Dealloc

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    self.label = nil;
    self.container = nil;
    [super dealloc];
}

@end
