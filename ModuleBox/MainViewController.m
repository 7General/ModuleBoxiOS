//
//  MainViewController.m
//  ModuleBox
//
//  Created by ZZG on 2020/4/28.
//  Copyright © 2020 ZZG. All rights reserved.
//

#import "MainViewController.h"
#import "ModuleCenter.h"
#import "SecViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"----%s",__func__);
//    ModuleCenter * mc = [[ModuleCenter alloc] init];
////    [mc autorelease];
//    [mc test];
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SecViewController * sec = [[SecViewController alloc] init];
    [self.navigationController pushViewController:sec animated:YES];
}

@end
