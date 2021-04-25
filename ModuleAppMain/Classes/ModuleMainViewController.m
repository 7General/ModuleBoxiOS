//
//  ModuleMainViewController.m
//  ModuleAppMain
//
//  Created by ZZG on 2020/4/29.
//

#import "ModuleMainViewController.h"
#import "ModuleHomeController.h"
#import "ModuleUIStackManager.h"
#import "ModuleMineViewController.h"
#import "ModuleTabBarButton.h"

@interface ModuleMainViewController ()

@end

@implementation ModuleMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"==appmain=============%@",BAIDUMAPKEY);
    [self customTabBar];
    [self addSubViewController];
}


- (void)customTabBar {
    NSArray *titles = @[@"首页",@"我的"];
    UIColor *titleNormalColor = [UIColor grayColor];
    UIColor *titleSelectedColor = [UIColor redColor];
    NSMutableArray *munormals = @[].mutableCopy;
    NSMutableArray *muselects = @[].mutableCopy;
    for (int i = 0 ; i < titles.count ; i++) {
        NSString *normalName = [NSString stringWithFormat:@"tab_normal_icon%d",i+1];
        NSString *selectlName = [NSString stringWithFormat:@"tab_pressed_icon%d",i+1];
        [munormals addObject:normalName];
        [muselects addObject:selectlName];
    }
    
    //    ModuleTabBarButton *btn = [self.mainCustomTabBar itemByIndex:0];
    // 如果没有添加过
    NSMutableArray *buttons = @[].mutableCopy;
    for (NSInteger i = 0 ; i < titles.count ; i++) {
        [buttons addObject:[[ModuleTabBarButton alloc] initWithTitle:titles[i]
                                                    titleNormalColor:titleNormalColor
                                                  titleSelectedColor:titleSelectedColor
                                                               image:[UIImage imageNamed:munormals[i]]
                                                       selectedImage:[UIImage imageNamed:muselects[i]]]];
    }
    [self.mainCustomTabBar setItems:buttons.copy];
    
}

- (void)addSubViewController {
    ModuleHomeController * homeVC = [[ModuleHomeController alloc] init];
    ModuleMineViewController * mineVC = [[ModuleMineViewController  alloc] init];
    
    [self setViewControllers:@[homeVC,mineVC]];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
    [self.mainCustomTabBar setSelectedIndex:selectedIndex];
    
    UINavigationController * currentNav = [self.viewControllers objectAtIndex:selectedIndex];
    [[ModuleUIStackManager shareInstance] setCurrentNavigation:currentNav];
}

- (void)tabBarView:(ModuleTabBar *)tabBarView didSelectIndex:(NSUInteger )selectIndex lastSelectIndex:(NSUInteger)lastSelectIndex {
//    NSLog(@"------%ld",selectIndex);
    [self changeTabForSelectIndex:selectIndex];
}

- (void)changeTabForSelectIndex:(NSUInteger)selectIndex {
    //    UINavigationController *currentNav = [self.viewControllers objectAtIndex:selectIndex];
    //    UIViewController * vc = [currentNav.viewControllers firstObject];
    
    [self setSelectedIndex:selectIndex];
}





@end
