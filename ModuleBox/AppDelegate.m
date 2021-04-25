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
#import "UINavigationController+OpenApiCore.h"
#import "RAMExport.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ModuleMainViewController * tabbar = [[ModuleMainViewController alloc] init];
    [[ModuleUIStackManager shareInstance] setTabBarController:tabbar];
    NSLog(@"DBAIDUMAPKEYDBAIDUMAPKEY->%@",BAIDUMAPKEY);
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
    
//    MainViewController * main = [[MainViewController alloc] init];
//    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:main];
//    self.window.rootViewController = nav;
//    [self.window makeKeyAndVisible];
    
    return YES;
}

RAM_FUNCTION_EXPORT(A)(void) {
       printf("\nRAMStageB:test function A");
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"从哪个app跳转而来 Bundle ID: %@", sourceApplication);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL path:%@", [url path]);
    
    return true;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"从哪个app跳转而来 Bundle ID: %@", options);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL path:%@", [url path]);
    
    UINavigationController * nav = [[ModuleUIStackManager shareInstance] getCurrentNavigation];
    [nav pushModule:@"/index/vc1" animated:YES withParams:@{@"tttt":@"oooooo"} callback:^(NSDictionary * _Nonnull moduleInfo) {
        NSLog(@"moduleInfomoduleInfo--%@",moduleInfo);
    }];
    return true;
}




@end
