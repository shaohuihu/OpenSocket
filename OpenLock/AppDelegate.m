//
//  AppDelegate.m
//  OpenLock
//
//  Created by yons on 14-10-14.
//  Copyright (c) 2014年 yons. All rights reserved.
//


//本demo通俗易懂，需要配合服务器代码才能完成测试实现,服务器代码也已经上传。你也可以用你自己的服务器测试
//用法：先运行服务器，填写端口地址(本demo端口是:8888  本地IP 是 127.0.0.1)
//服务器代码可以通过宏改变客户端连接服务器的时间，可长可短。
//本demo是把网上一些复杂的socket抽出来，没有过多的复杂库，仅用GCDAsyncSocket
//demo用于深入开发socket通信的童鞋提供一些基本思路



#import "AppDelegate.h"
#import "viewController.h"
#import "LockNav.h"
@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController =[[LockNav alloc] initWithRootViewController:[[viewController alloc] init]];
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
}

@end
