//
//  NSObject+MLFinder.m
//  AlgorithmNotice
//
//  Created by ZZG on 2020/4/22.
//  Copyright © 2020 zzg. All rights reserved.
//

#import "NSObject+MLFinder.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

const void *const kLatestSenderKey = &kLatestSenderKey;

@implementation NSObject (MLFinder)

+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL {
    
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
//#endif
}



- (void)assertNotDealloc {
    NSLog(@"assertNotDeallocassertNotDealloc");
}


@end
