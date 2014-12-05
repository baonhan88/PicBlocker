//
//  AppDelegate.m
//  PicBlocker
//
//  Created by NhanB on 12/1/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:43.0/255.0 green:108.0/255.0 blue:71.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
      NSForegroundColorAttributeName,[UIColor whiteColor],
      NSForegroundColorAttributeName,[NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
      NSForegroundColorAttributeName,[UIFont fontWithName:@"Arial-Bold" size:17.0],
      NSFontAttributeName,
      nil]];
    
    // test DB
//    PhotoEntity *delete = [[PhotoEntity alloc] init];
//    delete.name = @"aaa";
//    [[DatabaseHelper shareDatabase] deletePhotoWithEntity:delete];
//    
//    NSMutableArray *photoList = [[DatabaseHelper shareDatabase] getPhotoList];
//    for (PhotoEntity *entity in photoList) {
//        DLog(@"photo name:%@ | path:%@ | isLock:%d", entity.name, entity.path, entity.isLock);
//    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
