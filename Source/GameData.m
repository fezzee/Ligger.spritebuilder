//
//  GameData.m
//  Ligger
//
//  Created by Gene Myers on 15/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameData.h"

@implementation GameData

static NSMutableDictionary* _settings;

/*
 *
 */
static Ligger _ligger = GeordieGunter;//default
+ (Ligger) ligger
{
    _settings = [self getGameSettings];
    NSNumber *numVal = [_settings objectForKey:@"Character"];
    _ligger = [numVal isEqualToNumber:[NSNumber numberWithInt:0]]?GeordieGunter:SparklePony; //Geordie = 0. Sparkle = 1
    NSLog(@"GameData::getLigger %@",_ligger==GeordieGunter? @"GeordieGunter" : @"SparklePony"); //Geordie = 0. Sparkle = 1
    return _ligger;
}
+ (void) setLigger:(Ligger)value
{
//    if(value==SparklePony)
//        NSLog(@"GameData::setLigger -> SparklePony Choosen");
//    else
//        NSLog(@"GameData::setLigger -> GeordieGunter Choosen");
    _ligger = value;
    
    _settings = [self getGameSettings];
    NSNumber * val = [NSNumber numberWithInt:_ligger];
    [_settings  setObject:val forKey:@"Character"];
    [self saveGameSettings:_settings];
    NSLog(@"GameData::setNavigation:@Ligger=%@",_ligger==GeordieGunter? @"GeordieGunter" : @"SparklePony");
}



/*
 *
 */
static NSNumber *_soundtrack = 0;//default
+ ( NSNumber*) soundtrack
{
    _settings = [self getGameSettings];
    _soundtrack = [_settings objectForKey:@"Soundtrack"];
    NSLog(@"GameData::getSoundtrack %@",_soundtrack==0? @"The Soul Immigrants" : @"the other");
    return _soundtrack;
}
+ (void) setSoundtrack:(NSNumber*)value
{
    _soundtrack = value;
    
    _settings = [self getGameSettings];
    [_settings  setObject:_soundtrack forKey:@"Soundtrack"];
    [self saveGameSettings:_settings];
    NSLog(@"GameData::setSoundtrack=%@",[_soundtrack isEqualToNumber:[NSNumber numberWithInt:0]]? @"The Soul Immigrants" : @"the other");
    NSLog(@"UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU");
   
}


/*
 *
 */
static Navigation _navigation = Swipe;//default
+ (Navigation) navigation
{
    _settings = [self getGameSettings];
    NSNumber *numVal = [_settings objectForKey:@"Movement"];
    _navigation = [numVal isEqualToNumber:[NSNumber numberWithInt:0]]?Swipe:Touch; //swipe = 0. Touch = 1
     NSLog(@"GameData::getNavigation %@",_navigation==Swipe? @"Swipe" : @"Touch"); //swipe = 0, touch = 1
    return _navigation;
}

+ (void) setNavigation:(Navigation)value
{
//    if(value==Touch)
//        NSLog(@"Setting Touch");
//    else
//        NSLog(@"Setting Swipe");
    _navigation = value;
    _settings = [self getGameSettings];
    NSNumber * val = [NSNumber numberWithInt:_navigation];
    [_settings  setObject:val forKey:@"Movement"];
    [self saveGameSettings:_settings];
    NSLog(@"GameData::setNavigation:@Movement=%@",_navigation==Swipe? @"Swipe" : @"Touch");
}

/*
 *
 */
static bool _audible = YES;//default audio is ON
+ (bool) audible {
    
    _settings = [self getGameSettings];
    //when reading a bool value back from plist, use boolValue (NSNumber)
    _audible = [[_settings objectForKey:@"Audio"] boolValue];
    NSLog(@"GameData::getAudible %@",_audible? @"TRUE" : @"FALSE");
    return _audible;
}
+ (void) setAudible:(bool)isOn
{
    _audible = isOn;
    
    _settings = [self getGameSettings];
    //when setting a plist file with a bool, use numberWithBool
    [_settings  setObject:[NSNumber numberWithBool:_audible] forKey:@"Audio"];
    [self saveGameSettings:_settings];
    NSLog(@"GameData::set objectForKey:@Audio=%@",_audible? @"TRUE" : @"FALSE");
}


/*
 *
 */
static NSString* _userName;
+ (NSString*) userName {
    
    _settings = [self getGameSettings];
    _userName = [_settings objectForKey:@"Username"];
    return _userName;
}
+ (void) setUserName:(NSString*)name {
    _userName = name;
    //write to the plist!!!!!
    _settings = [self getGameSettings];
    [_settings  setObject:_userName forKey:@"Username"];
    [self saveGameSettings:_settings];
    NSLog(@"GameData::set objectForKey:@Username=%@",_userName);
}



+(void) readAndInit
{
     NSLog(@"Read PList and init Instance Vars");
    
    if (_settings==nil)
    {
        [self getGameSettings];
    }
   
    _audible = [[_settings objectForKey:@"Audio"] boolValue]; //sets the bool correctly
    _ligger = [_settings objectForKey:@"Character"]?SparklePony:GeordieGunter; //0 = Male,1 = Female
    _navigation = [_settings objectForKey:@"Movement"]?Swipe:Touch; //0 = ,1 =
    _userName =  [_settings objectForKey:@"Username"];
    
}


////IS THIS BEING USED???????
//GameData* instance;
//-(id)  sharedInstance
//{
//    if (instance==nil)
//    {
//        instance = [[GameData alloc]init];
//        [GameData readAndInit];
//    }
//    return instance;
//}

// All of thee method also update the HUD

-(void) moveForward:(CGPoint)position atSecs:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 10;
    [self addToGameLog:@"moveForward" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
    
}
-(void) moveBack:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 10;
    [self addToGameLog:@"moveBack" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) moveBack2:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 20;
    [self addToGameLog:@"moveBack2" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) reachBartender:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 100;
    [self addToGameLog:@"reachBartender" atSecs:secs forPosition:CGPointMake(0,0)];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) finishOneBeer:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 500;
    [self addToGameLog:@"finishOneBeer" atSecs:secs forPosition:CGPointMake(0,0)];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) finishTwoBeers:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 1000;
    [self addToGameLog:@"finishTwoBeers" atSecs:secs forPosition:CGPointMake(0,0)];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) calcBonus:(int)secsRemaining forPromotor:(int)index hud:(CCLabelBMFont*)label
{
     _GameScore += (10*secsRemaining*index);
    //don't log the secsRemaing as secs
    NSMutableString *bonusMsg = [NSMutableString string];
    [bonusMsg appendFormat:@"Bonus SecsRemaing: %d Index: %d",secsRemaining, index];
    [self addToGameLog:bonusMsg atSecs:0 forPosition:CGPointMake(0,0)];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) MushroomMan:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 500;
    [self addToGameLog:@"MushroomMan" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];

}
-(void) goodTrip:(CGPoint) position  atSecs:(int)secs hud:(CCLabelBMFont*)label
{
     _GameScore += 200;
    [self addToGameLog:@"goodTrip" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) badTrip:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label
{
     _GameScore -= 400;
    [self addToGameLog:@"badTrip" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}

/////////////////////////////////////////////////////////////////////////////////////////


-(void) addToGameLog:(NSString*)msg atSecs:(int) seconds forPosition:(CGPoint) position
{
    NSMutableString *entry = [NSMutableString string];
    if (seconds!=0)
        [entry appendFormat:@"Seconds: %d",seconds];
    if (position.x !=0 && position.y != 0)
        [entry appendFormat:@" Position: %f.2,%f.2",position.x,position.y];
    [entry appendFormat:@" Msg: %@",msg];
    [_Gamelog addObject:entry];
    NSLog(@"%@",entry);
}

-(void) reset
{
    _GameScore = 0;
    _Gamelog = [[NSMutableArray alloc] init];
    NSMutableString *entry = [NSMutableString string];
    [entry appendFormat:@"GameStarted at: %@",[NSDate date]];
    [self addToGameLog:entry atSecs:0 forPosition:CGPointMake(0,0)];
}

-(void) printLog
{
    for (int i =0; i < self.Gamelog.count; i++)
    {
        NSLog(@">> %@",self.Gamelog[i]);
    }
}




+(void) saveGameSettings:(NSMutableDictionary*)gameData
{

    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"LiggerGamedata.plist"];
    
    [gameData writeToFile:destPath atomically:YES];
    NSLog(@"PList Written at %@",destPath);
    
    //should we check if it is empty, and if empty,
}



// see http://stackoverflow.com/questions/7628372/ios-how-to-write-a-data-in-plist
// should I use NSUserDefaults instead?
+(NSMutableDictionary*) getGameSettings
{
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"LiggerGamedata.plist"];
    
    // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    if (![fileManager fileExistsAtPath:destPath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"LiggerGamedata" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:destPath error:&error];
        
        if (error!=nil)
        {
            NSLog(@">> SaveGamesettings() ERROR: %@",[error localizedDescription]);
        }
        
    } else {
        NSLog(@"File Exists at path");
    }
    
    // Load the Property List.
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:destPath];
    
    NSLog(@"========= GameData::getGameSettings =================");
    NSLog(@"UserIdentifier: %@",[data objectForKey:@"UserIdentifier"]);
    NSLog(@"DeviceIdentifier: %@",[data objectForKey:@"DeviceIdentifier"]);
    NSLog(@"Username: %@",[data objectForKey:@"Username"]);
    NSLog(@"Character: %@",[[data objectForKey:@"Character"] integerValue]==0?@"GeordieGunter":@"SparklePony");
    NSLog(@"Movement: %@",[[data objectForKey:@"Movement"] integerValue]==1?@"Touch":@"Swipe");
    NSLog(@"Audio: %@",[[data objectForKey:@"Audio"] boolValue]? @"True" : @"False");
    NSLog(@"Soundtrack: %@",[[data objectForKey:@"Soundtrack"] integerValue]==0?@"The Soul Immigrants":@"The Caufield Beats");
    NSLog(@"=====================================================");
    
    return data;

}


@end