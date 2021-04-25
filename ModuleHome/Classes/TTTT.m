//
//  TTTT.m
//  ModuleHome
//
//  Created by ZZG on 2021/4/16.
//

#import "TTTT.h"

@implementation TTTT

- (instancetype)init
{
    self = [super init];
    if (self) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.closeHandler) {
                self.closeHandler();
            }
        });
    }
    return self;
}
- (void)setCloseHandler:(closeBlock _Nonnull)closeHandler {
    _closeHandler = [closeHandler copy];
}

- (void)eeeeeeee:(void(^)(void))complated {
    [TTTT ggg];
    self.closeHandler = complated;
}
+ (void)ggg{
    NSLog(@"ggggggggggggggg");
}

@end
