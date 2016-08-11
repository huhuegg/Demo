//
//  AppDelegate.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "ShareSDKOperation.h"
#import "LocalDataManager.h"
#import "GameScoreBoardViewController.h"
#import "XMPPDataManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"a");
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LoginViewController *mainViewController = [[LoginViewController alloc] init];
    if (mainViewController) {
        self.window.rootViewController = mainViewController;
    }
    [[LocalDataManager sharedInstance] initializeDB];
    [[CacheDataManager sharedInstance] load];
    self.window.backgroundColor = [UIColor clearColor];
    [self writeLocalNotification:@"亲，乐透帮帮忙将在整点准时开始，快来捞钱吧 ！" deplayAtHour:@[@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"]];
    application.applicationIconBadgeNumber = 0;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"background!!!!");
    [[XMPPDataManager instance] goOffline];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"terminate!!!!");
    [[XMPPDataManager instance] goOffline];
    
}

#pragma mark - 社交分享部分

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([[url host] isEqualToString:@"com.FreePai.Game"]) {
        NSArray *array = [[url query] componentsSeparatedByString:@"="];
        NSString *json = [BaseTools getStringFromURLString:[array lastObject]];
        NSData *jsondata = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [BaseTools decodeJsonString:jsondata];
        DLog(@"收到外部消息:%@",dict);
        ALERT(@"收到外部消息", json, @"好的");
        /*
        GameScoreBoardViewController *uninstallGameDetails = [[GameScoreBoardViewController alloc] init:@"32dd5akxiioq8a6x" name:@"GameOne"];
        [[BaseTools getCurrentRootViewController] presentViewController:uninstallGameDetails animated:YES completion:nil];
         */
        return YES;
    }
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"自由派"
                                                    message:notification.alertBody
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    //这里，你就可以通过notification的useinfo，干一些你想做的事情了
    application.applicationIconBadgeNumber -= 1;
}

//写入本地推送消息
-(void)writeLocalNotification:(NSString*)content deplayAtHour:(NSArray *)hours
{
    if (hours && hours.count >0) {
        for (NSString *hour in hours) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            [formatter setDateFormat:@"HH:mm:ss"];
            
            NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@:30:00",hour]];//触发通知的时间
            UILocalNotification* msg = [[UILocalNotification alloc]init];
            if (msg) {
                [msg setFireDate:date];
                msg.repeatInterval = NSDayCalendarUnit;
                msg.soundName = UILocalNotificationDefaultSoundName;
                [msg setAlertBody:content];
                [msg setAlertAction:@"打开"];
                msg.applicationIconBadgeNumber = 1;
                //NSString *name = [NSString stringWithFormat:@"freepai%@",hour];
                NSDictionary* infoDic = @{@"name": @"freepai"};
                [msg setUserInfo:infoDic];
                
                [[UIApplication sharedApplication]scheduleLocalNotification:msg];
            }
        }
    }
}



@end
