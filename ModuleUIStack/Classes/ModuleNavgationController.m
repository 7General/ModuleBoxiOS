//
//  ModuleNavgationController.m
//  ModuleUIStack
//
//  Created by ZZG on 2020/4/29.
//

#import "ModuleNavgationController.h"

@interface ModuleNavgationController ()

@end

@implementation ModuleNavgationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
//        self.navigationBar.translucent = NO;
//        self.interactivePopGestureRecognizer.enabled = YES;
     }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    if (self.viewControllers.count == 1) {
//        return NO;
//    } else {
//        return YES;
//    }
//}

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}


@end
