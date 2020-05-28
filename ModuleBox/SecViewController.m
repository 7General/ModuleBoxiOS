//
//  SecViewController.m
//  ModuleBox
//
//  Created by ZZG on 2020/5/27.
//  Copyright © 2020 ZZG. All rights reserved.
//

#import "SecViewController.h"
#import "BoxOpenApiProtocol.h"

@interface SecViewController ()<BoxOpenApiProtocol>

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

#pragma mark - BoxOpenApiProtocol
+ (NSString *)openApiName {
    return @"/index/vc1";
}

- (id)open:(NSDictionary *)params callback:(void(^)(NSDictionary *))callback {
    callback(@{@"SecViewController":@"love"});
    
    return self;
}

@end
