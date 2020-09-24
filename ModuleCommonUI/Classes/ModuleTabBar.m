//
//  ModuleTabBar.m
//  ModuleCommonUI
//
//  Created by ZZG on 2020/9/24.
//

#import "ModuleTabBar.h"


@interface ModuleTabBar()

@property (nonatomic,strong) NSMutableArray *itemArray;

@property (nonatomic, strong) ModuleTabBarButton *selectedItem;

@end

@implementation ModuleTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.itemArray = [NSMutableArray array];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -0.5);
        self.layer.shadowOpacity = 0.1;
    }
    return self;
}

- (void)dealloc {
    //    delegate = nil;
    //
    //    for (GJECTabBarButton *button in itemArray) {
    //        [button removeFromSuperview];
    //    }
    //    [itemArray removeAllObjects];
    //    itemArray = nil;
    //
    //    selectedItem = nil;
    
}

- (void)setItems:(NSArray *)items {
    if ([items count] == 0) {
        return;
    }
    
    for (ModuleTabBarButton *item in self.itemArray) {
        [item removeTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventTouchUpInside];
        [item removeFromSuperview];
    }
    [self.itemArray removeAllObjects];
    [self.itemArray addObjectsFromArray:items];
    
    
    NSInteger i = 0;
    for (ModuleTabBarButton *item in self.itemArray) {
        CGFloat singleWidth = self.frame.size.width / self.itemArray.count;
        [item addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventTouchUpInside];
        [item setFrame:CGRectMake(i * singleWidth, 0, singleWidth, self.frame.size.height)];
        [item setNeedsLayout];
        [self addSubview:item];
        i++;
    }
    
    self.selectedItem = (ModuleTabBarButton *)self.itemArray[0];
}

- (NSUInteger)selectedIndex {
    if (nil == self.selectedItem || nil == self.itemArray)
        return NSNotFound;
    
    return[self.itemArray indexOfObject:self.selectedItem];
}

- (void)changeIndex:(ModuleTabBarButton *)button {
    NSUInteger lastIndex = [self selectedIndex];
    NSUInteger index = [self.itemArray indexOfObject:button];
    
    //单击tabitem返回顶部
    if ([self.selectedItem isEqual:button]) {
        //        if (self.singleTapItem) {
        //            self.singleTapItem(index);
        //        }
    }
    
    [self setSelectedIndex:index];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarView:didSelectIndex:lastSelectIndex:)]) {
        [self.delegate tabBarView:self didSelectIndex:index lastSelectIndex:lastIndex];
    }
}


- (ModuleTabBarButton *)itemByIndex:(NSUInteger)index {
    if (index >= self.itemArray.count) {
        return nil;
    }
    return self.itemArray[index];
}

- (void)setSelectedIndex:(NSUInteger)index {
    for (ModuleTabBarButton *item in self.itemArray) {
        [item setSelected:NO];
        [item setGJHighlighted:NO];
    }
    
    ModuleTabBarButton *button = [self.itemArray objectAtIndex:index];
    [button setSelected:YES];
    [button setGJHighlighted:YES];
    
    self.selectedItem = button;
}

@end
