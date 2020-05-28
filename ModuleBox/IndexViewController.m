//
//  IndexViewController.m
//  ModuleBox
//
//  Created by ZZG on 2020/5/27.
//  Copyright © 2020 ZZG. All rights reserved.
//

#import "IndexViewController.h"
#import "BoxOpenApiProtocol.h"

@interface IndexViewController ()<BoxOpenApiProtocol>

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
}


#pragma mark - BoxOpenApiProtocol
+ (NSString *)openApiName {
    return @"/index/vc2";
}

- (id)open:(NSDictionary *)params callback:(void(^)(NSDictionary *))callback {
//    callback(params[@"key"]);
    callback(@{@"IndexViewController":@"love"});
    
    return self;
}

@end
