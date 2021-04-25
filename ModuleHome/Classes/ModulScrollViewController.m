//
//  ModulScrollViewController.m
//  ModuleHome
//
//  Created by ZZG on 2021/1/28.
//

#import "ModulScrollViewController.h"

@interface ModulScrollViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ModulScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, w,100)];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    UIView * itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 100)];
    itemView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:itemView];
    
    UIView * secView = [[UIView alloc] initWithFrame:CGRectMake(w * 1, 0, w, 100)];
    secView.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview:secView];
    
    UIView * thirdView = [[UIView alloc] initWithFrame:CGRectMake(w * 2, 0, w, 100)];
    thirdView.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:thirdView];
    
    UIView * tempView = [[UIView alloc] initWithFrame:CGRectMake(w * 3, 0, w, 100)];
    tempView.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:tempView];
    
    self.scrollView.contentSize = CGSizeMake(w * 4, 0);
    self.scrollView.pagingEnabled = YES;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    NSLog(@"-----%f----->>>>%f",offsetX,3 * w);
    if (offsetX >= 3 * w ) {
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    }
}


@end
