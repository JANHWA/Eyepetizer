//
//  AppDelegate.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "AppDelegate.h"
#import "ChoiceViewController.h"
#import "DiscoverViewController.h"
#import "RankViewController.h"
#import "CollectionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"app.sqlite"];

    [self configUI];    
    return YES;
}

- (void)configUI
{
    NSArray *className = @[@"ChoiceViewController",@"DiscoverViewController",@"RankViewController",@"CollectionViewController"];
    NSArray *titles = @[@"每日精选",@"发现更多",@"热门排行",@"我的收藏"];
    NSArray *imageName = @[@"home",@"tabbar_discover",@"btn_airplay_normal",@"person"];
    NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < className.count; i++) {
        
        Class class = NSClassFromString(className[i]);
        UIViewController *vc = [[class alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.title = titles[i];
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
        logo.image = [UIImage imageNamed:@"logo"];
        vc.navigationItem.titleView = logo;
        [arrayM addObject:nav];
        nav.tabBarItem.image = [UIImage imageNamed:imageName[i]];
    }
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = arrayM;
    self.window.rootViewController = tab;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // 清除缓存
    [MagicalRecord cleanUp];
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


@end
