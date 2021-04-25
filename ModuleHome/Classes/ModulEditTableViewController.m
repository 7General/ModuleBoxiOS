//
//  ModulEditTableViewController.m
//  ModuleAppMain
//
//  Created by ZZG on 2021/4/10.
//

#import "ModulEditTableViewController.h"
#import "TableViewCell.h"
#import "ModuleSwipeCellAction.h"

@interface ModulEditTableViewController ()<UITableViewDelegate,UITableViewDataSource,ModuleSwipeCellDelegate>

@property (nonatomic, strong) UITableView *editTableView;


@end

@implementation ModulEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.editTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.editTableView.delegate = self;
    self.editTableView.dataSource = self;
    [self.view addSubview:self.editTableView];
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  YES;
}
//If not implemented, all editable cells will have UITableViewCellEditingStyleDelete
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
    
}

// 必须写的方法（否则iOS 8无法删除，iOS 9及其以上不写没问题），和editActionsForRowAtIndexPath配对使用，里面什么不写也行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UIContextualAction *topRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"置顶" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//    NSLog(@"点击了置顶");
//}];
//
//    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//    NSLog(@"点击了删除");
//       TableViewCell * cell = [self.editTableView cellForRowAtIndexPath:indexPath];
//        for (UIView * item in cell.superview.subviews) {
//            NSLog(@"---");
//            uiswipeac
//        }
//}];
//
//    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction,topRowAction]];
//    return config;
//}

//从iOS11开始该方法被废弃
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //操作按钮点击的操作
        NSLog(@"置顶");
        TableViewCell * cell = [self.editTableView cellForRowAtIndexPath:indexPath];
        for (UIView * subItem in cell.superview.subviews) {
            if ([subItem isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
                for (UIView * item in subItem.subviews) {
                    
                    if ([item isKindOfClass:[UIButton class]]) {
                        UIButton * btn = (UIButton *)item;
                        UIButton * cusbtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        cusbtn.backgroundColor = [UIColor greenColor];
                        cusbtn.frame = CGRectMake(0, 0, 40, 45);
                        [subItem addSubview:cusbtn];
//                        [btn removeFromSuperview];
//                        btn.userInteractionEnabled = NO;
                        [btn setTitle:@"fuck" forState:UIControlStateNormal];
                        [btn setTitle:@"fuck" forState:UIControlStateSelected];
                        [btn setTitle:@"fuck" forState:UIControlStateHighlighted];
                    }
                }
            }
        }
    }];
    
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了删除");
    }];
    return @[topRowAction, deleteRowAction];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ids"];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ids"];
    }
    cell.delegate = self;
    cell.textLabel.text = @"123";
    return cell;
}
//
//
//
//
///**
// 选中了侧滑按钮
//
// @param swipeCell 当前响应的cell
// @param indexPath cell在tableView中的位置
// @param index 选中的是第几个action
// */
//- (void)swipeCell:(ModuleSwipeCell *)swipeCell atIndexPath:(NSIndexPath *)indexPath didSelectedAtIndex:(NSInteger)index
//{
//
//}
//
///**
// 告知当前位置的cell是否需要侧滑按钮
//
// @param swipeCell 当前响应的cell
// @param indexPath cell在tableView中的位置
// @return YES 表示当前cell可以侧滑, NO 不可以
// */
//- (BOOL)swipeCell:(ModuleSwipeCell *)swipeCell canSwipeRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
///**
// 返回侧滑事件
//
// @param swipeCell 当前响应的cell
// @param indexPath cell在tableView中的位置
// @return 数组为空, 则没有侧滑事件
// */
//- (nullable NSArray<ModuleSwipeCellAction *> *)swipeCell:(ModuleSwipeCell *)swipeCell editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ModuleSwipeCellAction *action3 = [ModuleSwipeCellAction rowActionWithStyle:TMSwipeCellActionStyleNormal title:@"备注" handler:^(ModuleSwipeCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        NSLog(@"备注");
//    }];
//    ModuleSwipeCellAction *action2 = [ModuleSwipeCellAction rowActionWithStyle:TMSwipeCellActionStyleDestructive title:@"删除" handler:^(ModuleSwipeCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        NSLog(@"删除");
//
//    }];
//    return @[action3, action2];
//}

@end
