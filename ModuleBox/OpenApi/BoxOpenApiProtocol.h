//
//  BoxOpenApiProtocol.h
//  ModuleBox
//
//  Created by ZZG on 2020/5/27.
//  Copyright © 2020 ZZG. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BoxOpenApiProtocol <NSObject>

/**
 模块名称

 @return 模块名称
 */
+ (NSString *)openApiName;

@optional
- (id)open:(NSDictionary *)params callback:(void(^)(NSDictionary *))callback;

- (id)open_present:(NSDictionary *)params callback:(void(^)(NSDictionary *))callback;
@end
