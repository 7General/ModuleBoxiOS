//
//  UINavigationController+OpenApiCore.h
//  ModuleBox
//
//  Created by ZZG on 2020/5/27.
//  Copyright © 2020 ZZG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (OpenApiCore)

- (BOOL)pushModule:(NSString *)moduleName animated:(BOOL)animated withParams:(NSDictionary *)params callback:(void(^)(NSDictionary *moduleInfo))callback;


@end

NS_ASSUME_NONNULL_END
