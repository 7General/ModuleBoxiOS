//
//  MainViewController.m
//  ModuleBox
//
//  Created by ZZG on 2020/4/28.
//  Copyright © 2020 ZZG. All rights reserved.
//

#import "MainViewController.h"
#import "ModuleCenter.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"----%s",__func__);
    ModuleCenter * mc = [[ModuleCenter alloc] init];
    [mc test];
}


@end
