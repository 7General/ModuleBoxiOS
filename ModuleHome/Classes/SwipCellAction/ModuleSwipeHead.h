//
//  ModuleSwipeHead.h
//  ModuleAppMain
//
//  Created by ZZG on 2021/4/10.
//

#ifndef ModuleSwipeHead_h
#define ModuleSwipeHead_h


typedef NS_ENUM(NSInteger, TMSwipeCellActionStyle) {
    TMSwipeCellActionStyleDefault = 0,
    TMSwipeCellActionStyleDestructive = TMSwipeCellActionStyleDefault,  // 删除 红底
    TMSwipeCellActionStyleNormal                                        // 正常 灰底
};

typedef NS_ENUM(NSInteger, TMSwipeCellActionAnimationStyle) {
    TMSwipeCellActionAnimationStyleDefault = 0,    // 正常 点击就执行
    TMSwipeCellActionAnimationStyleAnimation = 1,  // 动画 点击就执行动画，寻求再次确认 : 注意 Destructive|Default 属性默认执行动画
};

typedef NS_ENUM(NSInteger, TMSwipeActionButtonStyle) {
    TMSwipeActionButtonStyleNormal = 0,     //正常状态：动画前
    TMSwipeActionButtonStyleSelected = 1,   //选中状态：动画后
};

typedef NS_ENUM(NSInteger, TMSwipeCellState) {
    TMSwipeCellStateNormal,
    TMSwipeCellStateAnimating,
    TMSwipeCellStateOpen
};

#endif /* ModuleSwipeHead_h */
