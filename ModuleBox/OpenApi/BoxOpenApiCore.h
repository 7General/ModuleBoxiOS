//
//  BoxOpenApiCore.h
//  ModuleBox
//
//  Created by ZZG on 2020/5/27.
//  Copyright © 2020 ZZG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BoxOpenApiCore : NSObject



+ (instancetype)openApiCore;

@property (nonatomic, copy) NSString *openApiScheme;


- (id)openApiName:(NSString *)moduleName openWithParams:(NSDictionary *)params callback:(void(^)(NSDictionary *moduleInfo))callback;


@end

NS_ASSUME_NONNULL_END
