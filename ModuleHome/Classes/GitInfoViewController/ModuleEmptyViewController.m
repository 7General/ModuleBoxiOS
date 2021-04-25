//
//  ModuleEmptyViewController.m
//  ModuleHome
//
//  Created by ZZG on 2021/4/25.
//

#import "ModuleEmptyViewController.h"

@interface ModuleEmptyViewController ()

@end

@implementation ModuleEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)goBack {
    NSLog(@"ggggggggggg");
}

@end
