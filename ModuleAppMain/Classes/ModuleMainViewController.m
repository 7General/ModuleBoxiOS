//
//  ModuleMainViewController.m
//  ModuleAppMain
//
//  Created by ZZG on 2020/4/29.
//

#import "ModuleMainViewController.h"
#import "ModuleHomeController.h"
#import "ModuleUIStackManager.h"

@interface ModuleMainViewController ()

@end

@implementation ModuleMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ModuleHomeController * homeVC = [[ModuleHomeController alloc] init];
    homeVC.title=@"ww";
    [self setViewControllers:@[homeVC]];
//    NSLog(@"===============%@",BaiduWebLBSAPIAK);
    
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    NSLog(@"--");
    
    UINavigationController * currentNav = [self.viewControllers objectAtIndex:selectedIndex];
    [[ModuleUIStackManager shareInstance] setCurrentNavigation:currentNav];
}





@end
