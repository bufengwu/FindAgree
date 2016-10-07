//
//  AppDelegate.m
//  FindAgree
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "AppDelegate.h"
#import "rootViewController.h"
#import "FAleftSliderViewController.h"
#import "FAnavViewController.h"
#import "FAtabViewController.h"

#import "FAfirstViewController.h"
#import "FAsecondViewController.h"
#import "FAthirdViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:0.1];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    FAfirstViewController * firstPageVC = [[FAfirstViewController alloc]init];
    UINavigationController * firstPageNav = [[FAnavViewController alloc]initWithRootViewController:firstPageVC];
    firstPageNav.tabBarItem.title= [FAUtils getLabelByName:@"Discover new content"];
    firstPageNav.tabBarItem.image=[FAUtils getImageByName:@"discover"];
    firstPageNav.tabBarItem.badgeValue=@"1";
    
    
    FAsecondViewController * secondPageVC = [[FAsecondViewController alloc]init];
    UINavigationController * secondPageNav = [[FAnavViewController alloc] initWithRootViewController:secondPageVC];
    secondPageNav.tabBarItem.title= [FAUtils getLabelByName:@"Offer a reward"];
    secondPageNav.tabBarItem.image=[FAUtils getImageByName:@"reword"];
    
    
    FAthirdViewController * thirdPageVC = [[FAthirdViewController alloc]init];
    UINavigationController * thirdPageNav = [[FAnavViewController alloc]initWithRootViewController:thirdPageVC];
    thirdPageNav.tabBarItem.title= [FAUtils getLabelByName:@"personal center"];
    thirdPageNav.tabBarItem.image=[FAUtils getImageByName:@"personal"];
    
    
    UITabBarController * tabVC = [[FAtabViewController alloc]init];
    tabVC.viewControllers = @[firstPageNav, secondPageNav, thirdPageNav];

    FAleftSliderViewController * leftSliderVC = [[FAleftSliderViewController alloc] init];
    
    rootViewController *rootVC = [[rootViewController alloc]initWithLeftSliderVC:leftSliderVC andMainVC:tabVC];
    
    self.window.rootViewController = rootVC;
    
    firstPageVC.delegate = rootVC;
    secondPageVC.delegate = rootVC;
    
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
