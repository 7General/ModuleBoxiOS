//
//  ModuleUIStackManager.h
//  ModuleUIStack
//
//  Created by ZZG on 2020/4/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModuleUIStackManager : NSObject

+ (instancetype)shareInstance;
- (UINavigationController *)getCurrentNavigation;
- (void)setCurrentNavigation:(UINavigationController *)navigation;
- (UITabBarController *)getTabBarController;
- (void)setTabBarController:(UITabBarController *)controller;
- (void)setStackViewController:(UIViewController *)controller;
- (UIViewController *)getStackViewController;

@end

NS_ASSUME_NONNULL_END
