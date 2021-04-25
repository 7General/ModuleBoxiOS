//
//  InterViewScrollView.m
//  ModuleBox
//
//  Created by ZZG on 2021/1/27.
//  Copyright © 2021 ZZG. All rights reserved.
//

#import "InterViewScrollView.h"

@interface InterViewScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *ivScrollView;

@end

@implementation InterViewScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setupView {
    NSMutableArray * dataSource = [NSMutableArray array];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    self.ivScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.ivScrollView.delegate = self;
    [self addSubview:self.ivScrollView];
    
    for (NSInteger index = 0; index < 3; index++) {
        UIView * item = [[UIView alloc] initWithFrame:CGRectMake(w * index, 0, w, h)];
        item.backgroundColor = [UIColor redColor];
        [dataSource addObject:item];
        [self.ivScrollView addSubview:item];
    }
    self.ivScrollView.contentSize = CGSizeMake(3 * w, h);
    //
    UIView * firstView = [dataSource firstObject];
    [self.ivScrollView addSubview:firstView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if (offsetX > 3 * w) {
//        [self.ivScrollView setContentOffset:CGPointMake(<#CGFloat x#>, <#CGFloat y#>)]
    }
}
// didendscroll
// abcccc

@end
