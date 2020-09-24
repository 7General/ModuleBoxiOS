//
//  ModuleTabBar.h
//  ModuleCommonUI
//
//  Created by ZZG on 2020/9/24.
//

#import <UIKit/UIKit.h>
#import "ModuleTabBarButton.h"

NS_ASSUME_NONNULL_BEGIN

@class ModuleTabBar;

@protocol ModuleTabBarDelegate <NSObject>
@required
// 选择一个按钮
- (void)tabBarView:(ModuleTabBar *)tabBarView didSelectIndex:(NSUInteger )selectIndex lastSelectIndex:(NSUInteger)lastSelectIndex;
@end

@interface ModuleTabBar : UIView

@property (nonatomic, readonly) ModuleTabBarButton *selectedItem;

@property (nonatomic,weak) id<ModuleTabBarDelegate> delegate;

// 选其中一个
- (ModuleTabBarButton *)itemByIndex:(NSUInteger)index;

- (void)setSelectedIndex:(NSUInteger)index;

- (void)setItems:(NSArray *)items;


@end

NS_ASSUME_NONNULL_END
