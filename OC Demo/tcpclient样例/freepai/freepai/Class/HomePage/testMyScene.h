//
//  testMyScene.h
//  ttt
//

//  Copyright (c) 2014年 huhuegg. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface testMyScene : SKScene <SKPhysicsContactDelegate>
@property BOOL status;

@property int playTimes;

@property SKLabelNode *startLabel;
@property CGFloat verticalPipeGap;
@property SKSpriteNode *bird;
@property SKTexture *pipeTextureUp;
@property SKTexture *pipeTextureDown;
@property SKAction *spawnThenDelayForever;
@property SKAction *movePipesAndRemove;
@property SKAction *moveGroundSpriteForever;

-(void)didBeginContact:(SKPhysicsContact *)contact;

-(CGFloat)clamp:(CGFloat)min max:(CGFloat)max value:(CGFloat)value;
@end
