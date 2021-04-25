//
//  BaseViewController.m
//  ModuleHome
//
//  Created by ZZG on 2021/4/25.
//

#import "BaseViewController.h"
#import "UIViewController+NavigationBar.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor = [UIColor redColor];
//    [btn setFrame:CGRectMake(0, 0, 45, 44)];
//    [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self setNavigationBackButton:self withSelector:@selector(goBack)];

}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)goBacks {
    NSLog(@"-----%s",__func__);
}




@end
