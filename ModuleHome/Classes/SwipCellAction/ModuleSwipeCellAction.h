//
//  ModuleSwipeCellAction.h
//  ModuleAppMain
//
//  Created by ZZG on 2021/4/10.
//

#import <Foundation/Foundation.h>
#import "ModuleSwipeHead.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModuleSwipeCellAction : NSObject


@property (nonatomic, copy) void (^handler)(ModuleSwipeCellAction *action, NSIndexPath *indexPath);
@property (nonatomic, assign) TMSwipeCellActionStyle style;

+ (instancetype)rowActionWithStyle:(TMSwipeCellActionStyle)style title:(nullable NSString *)title handler:(void (^)(ModuleSwipeCellAction *action, NSIndexPath *indexPath))handler;
/**  是否需要执行确认动画. 默认Default */
@property (nonatomic, assign) TMSwipeCellActionAnimationStyle animationStyle;
                                                                                //style == TMSwipeCellActionStyleDestructive ||
                                                                                //animationStyle == TMSwipeCellActionAnimationStyleAnimation 执行动画
/**  文字内容 */
@property (nonatomic, strong) NSString *title;
/**  按钮图片. 默认无图 */
@property (nonatomic, strong) UIImage *image;
/**  文字颜色. 默认白色 */
@property (nonatomic, strong) UIColor *titleColor;
/**  背景颜色. 默认透明 : 级别优先于 style */
@property (nonatomic, strong) UIColor *backgroundColor;
/**  内容左右间距. 默认15 */
@property (nonatomic, assign) CGFloat margin;
/**  字体大小. 默认17 */
@property (nonatomic, strong) UIFont *font;

/* 设置需要显示confirm的text和icon */
/**  再次确认的文字描述. 默认空 */
@property (nonatomic, strong)NSString *confirmTitle;
/**  再次确认的图片icon. 默认空 */
@property (nonatomic, strong)NSString *confirmIcon;



@end

NS_ASSUME_NONNULL_END
