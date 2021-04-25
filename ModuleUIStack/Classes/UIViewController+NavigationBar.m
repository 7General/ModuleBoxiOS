//
//  ModuleNavgationController+NavigationBar.m
//  ModuleHome
//
//  Created by ZZG on 2021/4/25.
//

#import "UIViewController+NavigationBar.h"

@implementation UIViewController (NavigationBar)

-(void)setNavigationBackButton:(UIViewController *)target withSelector:(SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor greenColor];
//    UIImage *iconImg = [UIImage imageNamed:@"nav_back_left_arrow"];
//    [btn setExclusiveTouch:YES];
//    btn.showsTouchWhenHighlighted = NO;
    [btn setFrame:CGRectMake(0, 0, 45, 44)];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
//    [btn setImage:iconImg forState:UIControlStateNormal];
    target.navigationItem.backBarButtonItem = nil;
//    if (IOS11) btn.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;

    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                       target:nil action:nil];
//    negativeSpacer.width = -20;
    self.navigationItem.leftBarButtonItems = @[leftBarItem];
}

@end
