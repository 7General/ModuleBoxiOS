//
//  BoxOpenApiCore.m
//  ModuleBox
//
//  Created by ZZG on 2020/5/27.
//  Copyright © 2020 ZZG. All rights reserved.
//

#import "BoxOpenApiCore.h"
#import <objc/runtime.h>
#import "BoxOpenApiProtocol.h"

@interface BoxOpenApiCore ()
@property (nonatomic, strong) NSMutableDictionary *cache;
@end

@implementation BoxOpenApiCore


+ (instancetype)openApiCore {
    static BoxOpenApiCore *openApiCore;
      static dispatch_once_t onceToken;
      dispatch_once(&onceToken, ^{
          openApiCore = [[BoxOpenApiCore alloc] init];
      });
      return openApiCore;
}

- (instancetype)init {
    self = [super init];
    if (self) {
//        [self cacheModuleProrocolClasses];
    }
    return self;
}
#pragma mark - Public
- (id)openApiName:(NSString *)moduleName openWithParams:(NSDictionary *)params callback:(void(^)(NSDictionary *moduleInfo))callback {
    NSCAssert(moduleName != nil, @"moduleName can not be nil!");
    id module = [self openApiName:moduleName performSelectorName:@"open:callback:" withParams:params callback:callback];
    if (module == nil) {
        module = [self openApiName:moduleName performSelectorName:@"open_present:callback:" withParams:params callback:callback];
    }
    return module;
}

#pragma mark - Private
/**
 把遵守HCModuleProtocol的类缓存起来
 */
- (void)cacheModuleProrocolClasses {
    if (_cache.count != 0) {
        return;
    }
    NSMutableDictionary *tmpCache = [NSMutableDictionary dictionary];
    Class *classes;
    unsigned int outCount;
    classes = objc_copyClassList(&outCount);//获取全部类
    for (int i = 0; i < outCount; i++) {
        Class class = classes[i];
        
        //实现了HCModuleProtocol的类
        if (class_conformsToProtocol(class, @protocol(BoxOpenApiProtocol))) {
            NSString *moduleName = [class openApiName];
            //重复检查
            NSCAssert([tmpCache objectForKey:moduleName] == nil, @"in class %@, module %@ has defined, please check!", NSStringFromClass(class), moduleName);
            [tmpCache setObject:NSStringFromClass(class) forKey:moduleName];
        }
    }
    free(classes);
    self.cache = [tmpCache copy];
}

//获取缓存起来的响应相应协议方法的类
- (id)openApiName:(NSString *)moduleName performSelectorName:(NSString *)selectorName withParams:(NSDictionary *)params callback:(void(^)(NSDictionary *moduleInfo))callback {
    NSCAssert(moduleName != nil && selectorName != nil, @"moduleName and selectorName can not be nil!");
    id module;
    NSString *clsName = self.cache[moduleName];
    if (clsName.length) {
        Class class = NSClassFromString(clsName);//根据缓存的类名字创建类
        SEL selec = NSSelectorFromString(selectorName);
        if (class) {
            id target = [[class alloc] init];//初始化一个类的对象
            if ([target respondsToSelector:selec]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                module = [target performSelector:selec withObject:params withObject:callback];
#pragma clang diagnostic pop
            }
        }
    }
    return module;
}
@end
