//
//  ModuleMustOverrideViewController.m
//  ModuleHome
//
//  Created by ZZG on 2020/11/19.
//

#import "ModuleMustOverrideViewController.h"
#import "ModulePerson.h"
#import "ModuleChildren.h"

@interface ModuleMustOverrideViewController ()

@end

@implementation ModuleMustOverrideViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ModulePerson * person = [[ModulePerson alloc] init];
    ModuleChildren * child = [[ModuleChildren alloc] init];
    [child someMethod];
}


@end
