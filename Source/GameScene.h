//
//  GameScene.h
//  Ligger
//
//  Created by Gene Myers on 19/04/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface GameScene : CCNode

@property (nonatomic) NSMutableArray* obstacles;
@property (nonatomic) NSMutableArray* bartenders;
@property (nonatomic) NSMutableArray* promotors;
@property (nonatomic) CCNode *obstacle1;
@property (nonatomic) CCNode *obstacle2;
@property (nonatomic) CCNode *obstacle3;
@property (nonatomic) CCNode *obstacle4;
@property (nonatomic) CCNode *obstacle5;
@property (nonatomic) CCNode *obstacle6;
@property (nonatomic) CCNode *obstacle7;
@property (nonatomic) CCNode *obstacle8;
@property (nonatomic) CCNode *obstacle9;
@property (nonatomic) CCNode *obstacle10;
@property (nonatomic) CCNode *bartender1;
@property (nonatomic) CCNode *bartender2;
@property (nonatomic) CCNode *bartender3;
@property (nonatomic) CCNode *bartender4;
@property (nonatomic) CCNode *bartender5;

+ (Boolean) halt;
+ (void) setHalt:(Boolean)value;


-(Boolean) doesCollide:(CCNode*)obstacle withPlayer:(CCNode*) player;
- (void)startHustleLeft;
- (void)startHustleRight;
- (void)startHustleUp;
- (void)startHustleDown;


@end
