//
//  ModuleMainViewController.m
//  ModuleAppMain
//
//  Created by ZZG on 2020/4/29.
//

#import "ModuleMainViewController.h"
#import "ModuleHomeController.h"

@interface ModuleMainViewController ()

@end

@implementation ModuleMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ModuleHomeController * homeVC = [[ModuleHomeController alloc] init];
    homeVC.title=@"ww";
    [self setViewControllers:@[homeVC]];
    NSLog(@"===============%@",BaiduWebLBSAPIAK);
    
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    NSLog(@"--");
}





@end
