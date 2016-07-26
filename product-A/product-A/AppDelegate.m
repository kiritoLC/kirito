//
//  AppDelegate.m
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible ];
    
    RootViewController *root = [[RootViewController alloc]init];
    
    self.window.rootViewController = root;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    
    view.backgroundColor = [UIColor blackColor];
    [self.window addSubview:view];
    
        [ShareSDK registerApp:@"iosv1101"
         
              activePlatforms:@[

                                @(SSDKPlatformTypeWechat)
                               
                                ]
                     onImport:^(SSDKPlatformType platformType)
         {
             switch (platformType)
             {
                 case SSDKPlatformTypeWechat:
                     [ShareSDKConnector connectWeChat:[WXApi class]];
                     
                     break;
                     
                default:
                     
                     break;
                     
             }
         }
              onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
         {
             
             switch (platformType)
             {
                                 case SSDKPlatformTypeWechat:
                     [appInfo SSDKSetupWeChatByAppId:@"wx4c2169b3f8b88c62"
                                           appSecret:@"bfa71b2251df9aa41e2df2f26f4eb3bf"];
                     break;
                     
                default:
                     
                     break;
             }
             
         }];
    
    [NSThread sleepForTimeInterval:5];

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
