//
//  ModuleUIStackManager.m
//  ModuleUIStack
//
//  Created by ZZG on 2020/4/29.
//

#import "ModuleUIStackManager.h"


static ModuleUIStackManager *gStackInstance = nil;

@interface ModuleUIStackManager()
{
    UINavigationController *_currentNavigation;
    UITabBarController *_tabBarCtrl;
    __weak UIViewController *_targetVC;
}

@end


@implementation ModuleUIStackManager

+ (instancetype)shareInstance
{
    @synchronized(self) {
        if(gStackInstance == nil) {
            gStackInstance = [[ModuleUIStackManager alloc] init];
        }
    }
    return gStackInstance;
}

- (UINavigationController *)getCurrentNavigation
{
    return _currentNavigation;
}

- (void)setCurrentNavigation:(UINavigationController *)navigation
{
    _currentNavigation = navigation;
}

- (UITabBarController *)getTabBarController
{
    return _tabBarCtrl;
}

- (void)setTabBarController:(UITabBarController *)controller
{
    _tabBarCtrl = controller;
}

- (void)setStackViewController:(UIViewController *)controller
{
    _targetVC = controller;
}

- (UIViewController *)getStackViewController
{
    return _targetVC;
}

@end
