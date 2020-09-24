//
//  ModuleTabbarViewController.m
//  ModuleCommonUI
//
//  Created by ZZG on 2020/4/29.
//

#import "ModuleTabbarViewController.h"
#import "ModuleNavgationController.h"

// 机型
//#define Is_FullScreen ([GZSystemUtil iPhoneXDevice] || [GZSystemUtil iPhoneXSMAXOrXRDevice]) //全面屏（目前有X/XS/XR/XSMAX）
//#define IPHONE_X     Is_FullScreen //X系列手机（目前有X/XS/XR/XSMAX

#define VSWidth                  MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) // 竖屏下面的宽度

@interface ModuleTabbarViewController ()<ModuleTabBarDelegate>

@end

@implementation ModuleTabbarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainCustomTabBar = [[ModuleTabBar alloc] initWithFrame:CGRectMake(0, 0, VSWidth, 49)];
    [self.mainCustomTabBar setUserInteractionEnabled:YES];
    [self.mainCustomTabBar setDelegate:self];
    [self.tabBar addSubview:self.mainCustomTabBar];
    
    self.mainCustomTabBar.backgroundColor = [UIColor whiteColor];
}


- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers animated:(BOOL)animated{
    NSMutableArray* tabbarControllers = [NSMutableArray arrayWithCapacity:12];
    
    for (UIViewController* controller in viewControllers) {
        UIViewController* rootController = controller;
        
        rootController = [[ModuleNavgationController alloc] initWithRootViewController:controller];
        
        [tabbarControllers addObject:rootController];
    }
    
    [super setViewControllers:tabbarControllers animated:animated];
    
    
    //    self.tabBar.backgroundColor = [UIColor whiteColor];
    //    for (UITabBarItem *item in self.tabBar.items) {
    //        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateNormal];
    //        item.enabled = NO;
    //    }
}


- (void)dealloc {
    _mainCustomTabBar.delegate = nil;
    [_mainCustomTabBar removeFromSuperview];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // 移除系统自带的tabBarButton
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [obj removeFromSuperview];
        }
    }];
}

- (void)tabBarView:(nonnull ModuleTabBar *)tabBarView didSelectIndex:(NSUInteger)selectIndex lastSelectIndex:(NSUInteger)lastSelectIndex {
    
}

@end
