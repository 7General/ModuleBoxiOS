//
//  AppDelegate.m
//  ModuleBox
//
//  Created by ZZG on 2020/4/28.
//  Copyright © 2020 ZZG. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ModuleMainViewController.h"
#import "ModuleUIStackManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ModuleMainViewController * tabbar = [[ModuleMainViewController alloc] init];
    [[ModuleUIStackManager shareInstance] setTabBarController:tabbar];
    
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}





@end
