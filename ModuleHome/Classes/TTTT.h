//
//  TTTT.h
//  ModuleHome
//
//  Created by ZZG on 2021/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TTTTDelegate <NSObject>



@end

typedef void(^closeBlock)(void);
@interface TTTT : NSObject

@property (nonatomic, copy) closeBlock closeHandler;
- (void)setCloseHandler:(closeBlock _Nonnull)closeHandler;
- (void)eeeeeeee:(void(^)())complated;



@end

NS_ASSUME_NONNULL_END
