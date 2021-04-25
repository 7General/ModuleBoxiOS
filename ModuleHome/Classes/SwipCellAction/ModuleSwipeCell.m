//
//  ModuleSwipeCell.m
//  ModuleAppMain
//
//  Created by ZZG on 2021/4/10.
//

#import "ModuleSwipeCell.h"


@interface ModuleSwipeCell()<UIGestureRecognizerDelegate, UITableViewDelegate>

@property (nonatomic, assign) BOOL sideslip;
@property (nonatomic, assign) TMSwipeCellState state;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <ModuleSwipeCellAction *>* actions;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *tableViewPan;

@end
@implementation ModuleSwipeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSideslipCell];
    }
    return self;
}


- (void)setupSideslipCell {
    // 添加拖拽手势
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewPan:)];
    self.panGesture.delegate = self;
    [self.contentView addGestureRecognizer:self.panGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 0;
    if (self.sideslip) x = self.contentView.frame.origin.x;
    
    [super layoutSubviews];
    CGFloat totalWidth = 0;
    for (ModuleSwipeActionButton *btn in self.btnContainView.subviews) {
        btn.frame = CGRectMake(totalWidth, 0, btn.frame.size.width, self.frame.size.height);
        totalWidth += btn.frame.size.width;
    }
    self.btnContainView.frame = CGRectMake(self.frame.size.width - totalWidth, 0, totalWidth, self.frame.size.height);
    
    // 侧滑状态旋转屏幕时, 保持侧滑
    if (_sideslip) [self setContentViewX:x];
    
    CGRect frame = self.contentView.frame;
    frame.size.width = self.bounds.size.width;
    self.contentView.frame = frame;
}


/// 擦掉数据
- (void)prepareForReuse {
    [super prepareForReuse];
    if (self.sideslip) [self hiddenSideslip:NO];
}


/// 拖拽事件
/// @param pan UIPanGestureRecognizer
- (void)contentViewPan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:pan.view];
    UIGestureRecognizerState state = pan.state;
    [pan setTranslation:CGPointZero inView:pan.view];
    
    if (state == UIGestureRecognizerStateChanged) {
        CGRect frame = self.contentView.frame;
        frame.origin.x += point.x;
        if (frame.origin.x > 15) {
            frame.origin.x = 15;
        } else if (frame.origin.x < -30 - self.btnContainView.frame.size.width) {
            frame.origin.x = -30 - self.btnContainView.frame.size.width;
        }
        self.contentView.frame = frame;
        
    } else if (state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [pan velocityInView:pan.view];
        if (self.contentView.frame.origin.x == 0) {
            return;
        } else if (self.contentView.frame.origin.x > 5) {
            [self hiddenWithBounceAnimation];
        } else if (fabs(self.contentView.frame.origin.x) >= 40 && velocity.x <= 0) {
            [self showSideslip];
        } else {
            [self hiddenSideslip:YES];
        }
        
    } else if (state == UIGestureRecognizerStateCancelled) {
        [self hiddenAllSideslip];
    }
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == _panGesture) {
        if (self.sideslip) {
            [self hiddenAllSideslip];
        }
        UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translation = [gesture translationInView:gesture.view];
        
        // 如果手势相对于水平方向的角度大于45°, 则不触发侧滑
        BOOL shouldBegin = fabs(translation.y) <= fabs(translation.x);
        if (!shouldBegin) return NO;
        
        // 询问代理是否需要侧滑
        if ([_delegate respondsToSelector:@selector(swipeCell:canSwipeRowAtIndexPath:)]) {
            shouldBegin = [_delegate swipeCell:self canSwipeRowAtIndexPath:self.indexPath] || _sideslip;
        }
        
        if (shouldBegin) {
            // 向代理获取侧滑展示内容数组
            if ([_delegate respondsToSelector:@selector(swipeCell:editActionsForRowAtIndexPath:)]) {
                NSArray <ModuleSwipeCellAction*> *actions = [_delegate swipeCell:self editActionsForRowAtIndexPath:self.indexPath];
                if (!actions || actions.count == 0) return NO;
                [self setActions:actions];
            } else {
                return NO;
            }
        }
        return shouldBegin;
    } else if (gestureRecognizer == _tableViewPan) {
        if (self.tableView.scrollEnabled) {
            return NO;
        }
    }
    return YES;
}

/* Response Events */
- (void)tableViewPan:(UIPanGestureRecognizer *)pan {
    if (!self.tableView.scrollEnabled && pan.state == UIGestureRecognizerStateBegan) {
        [self hiddenAllSideslip];
    }
}



/* 触发事件 */
- (void)actionBtnDidClicked:(ModuleSwipeActionButton *)btn {
    ModuleSwipeCellAction *action = _actions[btn.tag];
    if (btn.animationStyle == TMSwipeCellActionAnimationStyleAnimation) {
        if (btn.logStyle == TMSwipeActionButtonStyleSelected) {
            [self actionBtnDidClickToDule:btn.tag];
            return;
        }
        if (action.confirmTitle || action.confirmIcon) {
            [btn setTitle:action.confirmTitle forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:action.confirmIcon] forState:UIControlStateNormal];
        }else{
            [btn setTitle:@"确认删除" forState:UIControlStateNormal];
        }
        if (_actions.count == 1) {
            CGFloat width = [btn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : btn.titleLabel.font} context:nil].size.width;
            btn.frame = CGRectMake(0, 0, width + action.margin * 2, self.frame.size.height);
            btn.logStyle = TMSwipeActionButtonStyleSelected;
            [self layoutSubviews];
            [self showSideslip];
        } else {
            CGFloat width = _btnContainView.frame.size.width;
            btn.frame = CGRectMake(0, 0, width, self.frame.size.height);
            for (ModuleSwipeActionButton *button in _btnContainView.subviews) {
                if (button.tag != btn.tag) {
                    [button removeFromSuperview];
                }
            }
            btn.logStyle = TMSwipeActionButtonStyleSelected;
            [self layoutSubviews];
            [self showSideslip];
        }
    }else{
        [self actionBtnDidClickToDule:btn.tag];
    }
}

- (void)actionBtnDidClickToDule:(NSInteger)tag {
    if ([self.delegate respondsToSelector:@selector(swipeCell:atIndexPath:didSelectedAtIndex:)]) {
        [self.delegate swipeCell:self atIndexPath:self.indexPath didSelectedAtIndex:tag];
    }
    if (tag < _actions.count) {
        ModuleSwipeCellAction *action = _actions[tag];
        if (action.handler) action.handler(action, self.indexPath);
    }
    [self hiddenAllSideslip];
    self.state = TMSwipeCellStateNormal;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (_sideslip) {
        [self hiddenAllSideslip];
    }
}

#pragma mark - Methods
- (void)hiddenWithBounceAnimation {
    self.state = TMSwipeCellStateAnimating;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self setContentViewX:-10];
    } completion:^(BOOL finished) {
        [self hiddenSideslip:YES];
    }];
}

- (void)hiddenAllSideslip {
    [self.tableView hiddenAllSideslip];
}

- (void)hiddenSideslip:(BOOL)animate {
    if (self.contentView.frame.origin.x == 0){
        self.sideslip = NO;
        self.state = TMSwipeCellStateNormal;
        return;
    }
    
    self.state = TMSwipeCellStateAnimating;
//    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:(animate?0.12:0) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self setContentViewX:0];
    } completion:^(BOOL finished) {
        [self.btnContainView removeFromSuperview];
        self.btnContainView = nil;
        self.state = TMSwipeCellStateNormal;
    }];
}

- (void)showSideslip {
    self.state = TMSwipeCellStateAnimating;

    [UIView animateWithDuration:0.25 animations:^{
        [self setContentViewX:-self.btnContainView.frame.size.width];
    } completion:^(BOOL finished) {
        self.state = TMSwipeCellStateOpen;
    }];
}

#pragma mark - Setter
- (void)setContentViewX:(CGFloat)x {
    CGRect frame = self.contentView.frame;
    frame.origin.x = x;
    self.contentView.frame = frame;
}

- (void)setActions:(NSArray <ModuleSwipeCellAction *>*)actions {
    _actions = actions;
//        [UIView beginAnimations:nil context:nil];

    if (self.btnContainView) {
        [self.btnContainView removeFromSuperview];
        self.btnContainView = nil;
    }
    self.btnContainView = [UIView new];
    [self insertSubview:self.btnContainView belowSubview:self.contentView];
    
    for (int i = 0; i < actions.count; i++) {
        ModuleSwipeCellAction *action = actions[i];
        ModuleSwipeActionButton *btn = [ModuleSwipeActionButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.adjustsImageWhenHighlighted = NO;
        [btn setTitle:action.title?action.title:@"" forState:UIControlStateNormal];
        btn.titleLabel.font = action.font ? action.font : [UIFont systemFontOfSize:17];
        [btn addTarget:self action:@selector(actionBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (action.backgroundColor) {
            btn.backgroundColor = action.backgroundColor;
        } else {
            btn.backgroundColor = action.style == TMSwipeCellActionStyleNormal?[UIColor colorWithRed:200/255.0 green:199/255.0 blue:205/255.0 alpha:1] : [UIColor redColor];
        }
        
        if (action.image) {
            [btn setImage:action.image forState:UIControlStateNormal];
        }
        
        if (action.titleColor) {
            [btn setTitleColor:action.titleColor forState:UIControlStateNormal];
        }
        
        CGFloat width = [action.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : btn.titleLabel.font} context:nil].size.width;
        width += (action.image ? action.image.size.width : 0);
        btn.frame = CGRectMake(0, 0, width + action.margin*2, self.frame.size.height);
        
        //记录需要扩展动画的条件
        if (action.style == TMSwipeCellActionStyleDefault ||
            action.animationStyle == TMSwipeCellActionAnimationStyleAnimation) {
            btn.animationStyle = TMSwipeCellActionAnimationStyleAnimation;
        }
        
        [self.btnContainView addSubview:btn];
    }
//            [UIView commitAnimations];
}

- (void)setState:(TMSwipeCellState)state {
    _state = state;
    
    if (state == TMSwipeCellStateNormal) {
        for (ModuleSwipeCell *cell in self.tableView.visibleCells) {
            if ([cell isKindOfClass:ModuleSwipeCell.class]) {
                cell.sideslip = NO;
            }
        }
    } else if (state == TMSwipeCellStateAnimating) {
        NSLog(@"----->>%@", self);
    } else if (state == TMSwipeCellStateOpen) {
        for (ModuleSwipeCell *cell in self.tableView.visibleCells) {
            if ([cell isKindOfClass:ModuleSwipeCell.class]) {
                cell.sideslip = YES;
            }
        }
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        id view = self.superview;
        while (view && [view isKindOfClass:[UITableView class]] == NO) {
            view = [view superview];
        }
        _tableView = (UITableView *)view;
        _tableViewPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewPan:)];
        _tableViewPan.delegate = self;
        [_tableView addGestureRecognizer:_tableViewPan];
    }
    return _tableView;
}

- (NSIndexPath *)indexPath {
    return [self.tableView indexPathForCell:self];
}
@end
