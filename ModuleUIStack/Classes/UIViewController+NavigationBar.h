//
//  ModuleNavgationController+NavigationBar.h
//  ModuleHome
//
//  Created by ZZG on 2021/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NavigationBar)

- (void)setNavigationBackButton:(UIViewController *)target withSelector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
