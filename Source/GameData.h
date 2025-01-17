//
//  GameData.h
//  Ligger
//
//  GameData contains both static settings attributes and methods to tally the score and create a GameLog. The tallied score is stored in a ScoreData object and
//  saved to the GameData, along with the GameLog
//
//  Created by Gene Myers on 15/06/2015.
//  Copyright (c) 2015 Fezzee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@class ScoreData;
@interface GameData : NSObject

@property int GameScore;
@property (nonatomic) NSMutableArray* Gamelog; //this is the scoring moves
//@property (nonatomic) NSMutableArray* settings; //this are the app settings- see instance variable instead
//static NSMutableDictionary* _settings;

//Game Settings
+ (Ligger) ligger;
+ (void) setLigger:(Ligger)character;
+ (Navigation) navigation;
+ (void) setNavigation:(Navigation)character;
+ (bool) audible;
+ (void) setAudible:(bool)setOn;
+ (NSString*) userName;
+ (void) setUserName:(NSString*)name;
+ (NSString*) userID;
+ (void) setUserID:(NSString*)id_string;
+ (NSString*) deviceID;
+ (void) setDeviceID:(NSString*)id_string;
+ (NSNumber*) soundtrack;
+ (void) setSoundtrack:(NSNumber*)value;


+(void) saveGameSettings:(NSMutableDictionary*)gameData;
+(void) archiveGameSettings:(NSMutableDictionary*)gameData;
+(NSMutableDictionary*) getGameSettings;
+(void) readAndInit;
+(NSMutableDictionary*) getPersonalBest;

-(bool) updateHighScore:(ScoreData*)scoreData;


//log player actions
-(void) moveForward:(CGPoint) position atSecs:(int) secs hud:(CCLabelBMFont*)label; //
-(void) moveBack:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label; //
-(void) moveBack2:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label; //
-(void) reachBartender:(int)secs hud:(CCLabelBMFont*)label;
-(void) finishOneBeer:(int)secs hud:(CCLabelBMFont*)label;
-(void) finishTwoBeers:(int)secs hud:(CCLabelBMFont*)label;
-(void) calcBonus:(int)secsRemaining forPromotor:(int)index hud:(CCLabelBMFont*)label;
-(void) MushroomMan:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label;
-(void) goodTrip:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label;
-(void) badTrip:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label;

//Add Non-Scoring milestones- Collision1, Collision2, Levelup, Game Over to GameData
//TODO: Implement
-(void) collisionFinal:(CGPoint) position atSecs:(int)secs;
-(void) collisionInterim:(CGPoint) position atSecs:(int)secs;
-(void) logGameError:(NSString*)msg atSecs:(int)secs;

//////

-(void) reset;
-(void) printLog;


@end

/*
 
 Pass obstacle (forward only or back with 1 Beer): 10 points.
 
 Pass obstacle (forward only or back with 2 Beer): 20 points.
 
 Getting to Bartender: 100 points. (either for 2 or 1 beer)
 
 Returning with Two Beers: 1,000 points.
 
 Returning with One Beer: 500 points.
 
 Bonus score: 10 points x each second remaining on timer x Promotor Index (eg-1=Michael, 4=Rob).
 
 TO DO
 
 Mushroom Man: 500 points bonus.
 
 Good Trip: 200 points.
 
 Bad Trip: -400 points.
 
 */
