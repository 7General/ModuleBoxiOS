//
//  NSObject+MLFinder.h
//  AlgorithmNotice
//
//  Created by ZZG on 2020/4/22.
//  Copyright © 2020 zzg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MLFinder)

+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;
@end

NS_ASSUME_NONNULL_END
