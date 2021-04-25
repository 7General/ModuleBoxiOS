//
//  UITableView+ModuleSwipeCell.m
//  ModuleAppMain
//
//  Created by ZZG on 2021/4/10.
//

#import "UITableView+ModuleSwipeCell.h"

@implementation UITableView (ModuleSwipeCell)


- (void)hiddenAllSideslip {
    for (ModuleSwipeCell *cell in self.visibleCells) {
        if ([cell isKindOfClass:ModuleSwipeCell.class]) {
            [cell hiddenSideslip:NO];
        }
    }
}

@end
