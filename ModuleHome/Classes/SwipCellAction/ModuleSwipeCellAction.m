//
//  ModuleSwipeCellAction.m
//  ModuleAppMain
//
//  Created by ZZG on 2021/4/10.
//

#import "ModuleSwipeCellAction.h"

@interface ModuleSwipeCellAction()



@end

@implementation ModuleSwipeCellAction


+ (instancetype)rowActionWithStyle:(TMSwipeCellActionStyle)style title:(NSString *)title handler:(void (^)(ModuleSwipeCellAction *action, NSIndexPath *indexPath))handler {
    ModuleSwipeCellAction *action = [ModuleSwipeCellAction new];
    action.title = title;
    action.handler = handler;
    action.style = style;
    return action;
}

- (CGFloat)margin {
    return _margin == 0 ? 15 : _margin;
}
@end
