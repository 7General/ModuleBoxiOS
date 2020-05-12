//
//  ModuleTabbarViewController.m
//  ModuleCommonUI
//
//  Created by ZZG on 2020/4/29.
//

#import "ModuleTabbarViewController.h"
#import "ModuleNavgationController.h"

@interface ModuleTabbarViewController ()

@end

@implementation ModuleTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers animated:(BOOL)animated{
    NSMutableArray* tabbarControllers = [NSMutableArray arrayWithCapacity:12];
    
    for (UIViewController* controller in viewControllers) {
        UIViewController* rootController = controller;
        
//        if ([controller isKindOfClass:[GJECUIViewController class]] || [controller isKindOfClass:[GZECBaseWebViewController class]]) {
            rootController = [[ModuleNavgationController alloc] initWithRootViewController:controller];
//        }
        
        [tabbarControllers addObject:rootController];
    }
    
    [super setViewControllers:tabbarControllers animated:animated];
    
    
//    self.tabBar.backgroundColor = [UIColor whiteColor];
//    for (UITabBarItem *item in self.tabBar.items) {
//        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateNormal];
//        item.enabled = NO;
//    }
}

@end
