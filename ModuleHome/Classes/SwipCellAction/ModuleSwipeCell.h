//
//  ModuleSwipeCell.h
//  ModuleAppMain
//
//  Created by ZZG on 2021/4/10.
//

#import <UIKit/UIKit.h>
#import "ModuleSwipeCellAction.h"
#import "ModuleSwipeActionButton.h"
#import "UITableView+ModuleSwipeCell.h"

NS_ASSUME_NONNULL_BEGIN


@class ModuleSwipeCell;
@protocol ModuleSwipeCellDelegate <NSObject>
@optional;

/**
 选中了侧滑按钮

 @param swipeCell 当前响应的cell
 @param indexPath cell在tableView中的位置
 @param index 选中的是第几个action
 */
- (void)swipeCell:(ModuleSwipeCell *)swipeCell atIndexPath:(NSIndexPath *)indexPath didSelectedAtIndex:(NSInteger)index;

/**
 告知当前位置的cell是否需要侧滑按钮

 @param swipeCell 当前响应的cell
 @param indexPath cell在tableView中的位置
 @return YES 表示当前cell可以侧滑, NO 不可以
 */
- (BOOL)swipeCell:(ModuleSwipeCell *)swipeCell canSwipeRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 返回侧滑事件

 @param swipeCell 当前响应的cell
 @param indexPath cell在tableView中的位置
 @return 数组为空, 则没有侧滑事件
 */
- (nullable NSArray<ModuleSwipeCellAction *> *)swipeCell:(ModuleSwipeCell *)swipeCell editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ModuleSwipeCell : UITableViewCell

@property (nonatomic, weak) id<ModuleSwipeCellDelegate> delegate;

/**
 *  按钮容器
 */
@property (nonatomic, strong) UIView *btnContainView;

/**
 *  隐藏侧滑按钮
 */
- (void)hiddenAllSideslip;
- (void)hiddenSideslip:(BOOL)animate;


@end

NS_ASSUME_NONNULL_END
