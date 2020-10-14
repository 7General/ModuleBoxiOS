//
//  NSData+Base64.m
//  ModuleMine
//
//  Created by ZZG on 2020/10/14.
//

#import "NSData+Base64.h"


@interface NSString (Base64)

- (NSString *) stringPaddedForBase64;

@end

@implementation NSString (Base64)

- (NSString *) stringPaddedForBase64 {
    NSUInteger paddedLength = self.length + (self.length % 3);
    return [self stringByPaddingToLength:paddedLength withString:@"=" startingAtIndex:0];
}

@end

@implementation NSData (Base64)

- (instancetype) initWithBase64Str:(NSString *)base64String {
    return [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (NSString *) base64EncodedString {
    return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
