//
//  ModuleSwipeActionButton.h
//  ModuleAppMain
//
//  Created by ZZG on 2021/4/10.
//

#import <UIKit/UIKit.h>
#import "ModuleSwipeHead.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModuleSwipeActionButton : UIButton


/* 属性赋值来自[TMSwipeCellAction class]实例 */
@property (nonatomic, assign)TMSwipeCellActionAnimationStyle animationStyle;

/* 记录当前动画状态,仅仅在有动画效果下生效 */
@property (nonatomic, assign)TMSwipeActionButtonStyle logStyle;


@end

NS_ASSUME_NONNULL_END
