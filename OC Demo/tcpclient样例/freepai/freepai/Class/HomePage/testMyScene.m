//
//  testMyScene.m
//  ttt
//
//  Created by huhuegg on 14-6-5.
//  Copyright (c) 2014年 huhuegg. All rights reserved.
//

#import "testMyScene.h"
static const uint32_t birdCategory     =  0x01 << 0;
static const uint32_t pipeDownCategory =  0x01 << 1;
static const uint32_t pipeUpCategory    =  0x01 << 2;


@implementation testMyScene {

}

-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        _playTimes = 0;
        
        /* Setup your scene here */
        _status=YES;
        _verticalPipeGap = 60;
        
        /*
        _startLabel = [[SKLabelNode alloc]initWithFontNamed:@"Times New Roman"];
        _startLabel.fontSize=16;
        _startLabel.text = @"返回testViewController";
        [self addChild:_startLabel];
        
        // setup physics
        _startLabel.position = CGPointMake(20, 20);
        */
         
        // setup background color
        
        self.physicsWorld.gravity = CGVectorMake(0.0,-5.0);
        self.physicsWorld.contactDelegate=self;
        self.backgroundColor = [SKColor colorWithRed:81.0 green:192.0 blue:201.0 alpha:1.0];
        
        // ground
        SKTexture *groundTexture = [SKTexture textureWithImageNamed:@"land"];
        groundTexture.filteringMode = SKTextureFilteringNearest;
        NSTimeInterval time = 0.02*groundTexture.size.width*2.0;
        SKAction *moveGroupndSprite = [SKAction moveByX:-groundTexture.size.width*2.0 y:0 duration:time];
        SKAction *resetGroundSprite = [SKAction moveByX:groundTexture.size.width*2.0 y:0 duration:0.0];
        _moveGroundSpriteForever = [SKAction repeatActionForever:[SKAction sequence:@[moveGroupndSprite,resetGroundSprite]]];
        
        for (CGFloat i=0; i<2.0+self.frame.size.width/(groundTexture.size.width*2.0); ++i) {
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:groundTexture];
            [sprite setScale:2.0];
            [sprite setPosition:CGPointMake(i*sprite.size.width, sprite.size.height/2.0)];
            //NSLog(@"i=%f ,for sprite posX:%f posY:%f",i,sprite.position.x,sprite.position.y);
            [sprite runAction:_moveGroundSpriteForever];
            [self addChild:sprite];
            if (! _status) {
                [sprite setSpeed:0.0];
            }
        }
        
        //skyline
        SKTexture *skyTexture = [SKTexture textureWithImageNamed:@"sky"];
        //NSLog(@"skyTexture size width:%f height:%f",skyTexture.size.width,skyTexture.size.height);
        skyTexture.filteringMode = SKTextureFilteringNearest;
        
        NSTimeInterval timeSkyLine = 0.02*groundTexture.size.width*2.0;
        SKAction *moveSkySprite = [SKAction moveByX:-skyTexture.size.width*2.0 y:0 duration:timeSkyLine];
        SKAction *resetSkySprite = [SKAction moveByX:skyTexture.size.width*2.0 y:0 duration:0.0];
        SKAction *moveSkySpritesForever = [SKAction repeatActionForever:[SKAction sequence:@[moveSkySprite,resetSkySprite]]];
        
        for (CGFloat i=0; i<2.0+self.frame.size.width/(skyTexture.size.width*2.0); ++i) {
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:skyTexture];
            [sprite setScale:4];
            [sprite setZPosition:-20];
            [sprite setPosition:CGPointMake(i*sprite.size.width, sprite.size.height/2.0 + groundTexture.size.height*2.0)];
            //NSLog(@"skyline posX:%f posY:%f",sprite.position.x,sprite.position.y);
            [sprite runAction:moveSkySpritesForever];
            [self addChild:sprite];

        }
        
        // create the pipes textures
        _pipeTextureUp = [SKTexture textureWithImageNamed:@"PipeUp"];
        _pipeTextureUp.filteringMode = SKTextureFilteringNearest;
        _pipeTextureDown = [SKTexture textureWithImageNamed:@"PipeDown"];
        _pipeTextureDown.filteringMode = SKTextureFilteringNearest;
        
        //create the pipes movement actions
        CGFloat distanceToMove = self.frame.size.width + 2.0 * _pipeTextureUp.size.width;
        NSTimeInterval t = 0.01*distanceToMove;
        SKAction *movePipes = [SKAction moveByX:-distanceToMove y:0.0 duration: t];
        SKAction *removePipes = [SKAction removeFromParent];
        _movePipesAndRemove = [SKAction sequence:@[movePipes,removePipes]];
        
        // spawn the pipes
        SKAction *spawn = [SKAction runBlock:^{
            //() in self.spawnPipes()
            [self spawnPipes];
            _playTimes = _playTimes + 2;
            
        }];
        SKAction *delay = [SKAction waitForDuration:2.0];
        SKAction *spawnThenDelay = [SKAction sequence:@[spawn,delay]];
        _spawnThenDelayForever = [SKAction repeatActionForever:spawnThenDelay];
        [self runAction:_spawnThenDelayForever];
        
        
        // setup our bird
        SKTexture *birdTexture1 = [SKTexture textureWithImageNamed:@"bird-01"];
        birdTexture1.filteringMode = SKTextureFilteringNearest;
        SKTexture *birdTexture2 = [SKTexture textureWithImageNamed:@"bird-02"];
        birdTexture2.filteringMode = SKTextureFilteringNearest;
        
        
        SKAction *anim = [SKAction animateWithTextures:@[birdTexture1,birdTexture2] timePerFrame:0.2];
        SKAction *flap = [SKAction repeatActionForever:anim];
        
        _bird = [SKSpriteNode spriteNodeWithTexture:birdTexture1];
        [_bird setScale:2.0];
        [_bird setPosition:CGPointMake(self.frame.size.width*0.35, self.frame.size.height*0.6)];
        [_bird runAction:flap];
        
        [_bird setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:_bird.size.height/2.0]];
        _bird.physicsBody.dynamic = true;
        _bird.physicsBody.allowsRotation=false;
        
        _bird.physicsBody.categoryBitMask = birdCategory;
        _bird.physicsBody.contactTestBitMask = pipeDownCategory | pipeUpCategory;


        [self addChild:_bird];
        
        //create ground
        SKNode *ground = [[SKNode alloc]init];
        [ground setPosition:CGPointMake(0, groundTexture.size.height)];
        [ground setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, groundTexture.size.height*2.0)]];
        ground.physicsBody.dynamic = false;
        [self addChild:ground];
    }
    return self;
}


-(void) spawnPipes {
    SKNode *pipePair = [[SKNode alloc]init];
    [pipePair setPosition:CGPointMake(self.frame.size.width + _pipeTextureUp.size.width*2,0)];
    pipePair.zPosition = -10;
    
    int height = INT32_C(self.frame.size.height / 4);
    int y = arc4random() % height + height;
    
    
    SKSpriteNode *pipeDown = [[SKSpriteNode alloc]initWithTexture:_pipeTextureDown];
    [pipeDown setScale:2.0];
    [pipeDown setPosition:CGPointMake(0.0, (CGFloat)y + pipeDown.size.height + (CGFloat)_verticalPipeGap)];
    //NSLog(@"self.frame.size.height:%f   height:%i  y:%i verticalPipeGap:%f check:%f",self.frame.size.height,height,y,_verticalPipeGap,(CGFloat)y + pipeDown.size.height + (CGFloat)_verticalPipeGap);
    
    [pipeDown setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:pipeDown.size]];
    pipeDown.physicsBody.dynamic = false;
    pipeDown.physicsBody.categoryBitMask = pipeDownCategory;
    //pipeDown.physicsBody.contactTestBitMask = birdCategory;
    [pipePair addChild:pipeDown];
    

    SKSpriteNode *pipeUp = [[SKSpriteNode alloc]initWithTexture:_pipeTextureUp];
    [pipeUp setScale:2.0];
    [pipeUp setPosition:CGPointMake(0.0, y)];
    
    [pipeUp setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:pipeUp.size]];
    pipeUp.physicsBody.dynamic = false;
    pipeUp.physicsBody.categoryBitMask = pipeUpCategory;
    //pipeUp.physicsBody.contactTestBitMask = birdCategory;
    [pipePair addChild:pipeUp];
  
     
    [pipePair runAction:_movePipesAndRemove];
    [self addChild:pipePair];
    if (! _status) {
        pipePair.paused=YES;
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [_bird.physicsBody setVelocity:CGVectorMake(0, 0)];
        [_bird.physicsBody applyImpulse:CGVectorMake(0, 3.0)];
        
        
        
        //检查在次触屏位置所包含的节点
        NSArray *touchedNodes = [self nodesAtPoint:location];
        
        //遍历触屏位置所包含的节点
        for (int i=0;i<touchedNodes.count;i++) {
            //获取每个节点
            id touchedNode = [touchedNodes objectAtIndex:i];
            if ([touchedNode isEqual:_startLabel]) {

            }
        }
    }
}


-(CGFloat) clamp:(CGFloat)min max:(CGFloat)max value:(CGFloat)value {
    if (value>max) {
        return max;
    } else if (value < min) {
        return min;
    } else {
        return value;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    _bird.zPosition = [self clamp:-1 max:0.5 value:_bird.physicsBody.velocity.dy * (_bird.physicsBody.velocity.dy < 0 ? 0.003 : 0.001)];
    //_bird.zPosition = [self clamp:-1 max:0.5 value:_bird.physicsBody.velocity.dy * 0.001];
    if (_bird.position.x <= 0) {
        [self showScoreBoard];
    }
}

-(void)showScoreBoard {
    if (_status) {
        _status=NO;
        NSLog(@"Game Over");
        SKSpriteNode *scoreboardNode = [[SKSpriteNode alloc]initWithImageNamed:@"scoreboard"];
        [self addChild:scoreboardNode];

        scoreboardNode.position = CGPointMake(self.size.width/2, self.size.height/2);
        //设置背景图片锚点为图片中央位置
        scoreboardNode.anchorPoint = CGPointMake(0.5, 0.5);
        SKLabelNode *score = [[SKLabelNode alloc]initWithFontNamed:@"Times New Roman"];
        score.fontSize=12;
        score.color = [UIColor blackColor];
        score.text = [[NSString alloc]initWithFormat:@"%is",_playTimes];
        [scoreboardNode addChild:score];
        score.position = CGPointMake(35, 9);
        
        SKLabelNode *bestScore = [[SKLabelNode alloc]initWithFontNamed:@"Times New Roman"];
        bestScore.fontSize=12;
        bestScore.color = [UIColor blackColor];
        bestScore.text = @"888s";
        [scoreboardNode addChild:bestScore];
        bestScore.position = CGPointMake(35, -12);
        
        

    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    
    if (contact.bodyA.categoryBitMask == 1) {
        //NSLog(@"bodyA is bird,now bodyB is :%i",contact.bodyB.categoryBitMask);
        if (contact.bodyB.categoryBitMask == 4) {
            NSLog(@"bodyA is bird,bodyB is pipeUp");
        } else if (contact.bodyB.categoryBitMask == 2) {
            NSLog(@"bodyA is bird,bodyB is pipeDown");
        }
    } else if (contact.bodyB.categoryBitMask == 1) {
        //NSLog(@"bodyB is bird now bodyA is :%i",contact.bodyA.categoryBitMask);
        if (contact.bodyA.categoryBitMask == 4) {
            NSLog(@"bodyA is pipeUp ,bodyB is bird");
        } else if (contact.bodyA.categoryBitMask == 2) {
            NSLog(@"bodyA is pipeDown ,bodyB is bird");
        }
    }
}
@end
