//
//  NSData+Base64.h
//  ModuleMine
//
//  Created by ZZG on 2020/10/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Base64)

- (instancetype)initWithBase64Str:(NSString *)base64String;

- (NSString *) base64EncodedString;

@end

NS_ASSUME_NONNULL_END
