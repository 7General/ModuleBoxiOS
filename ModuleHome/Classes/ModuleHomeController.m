//
//  ModuleHomeController.m
//  ModuleHome
//
//  Created by ZZG on 2020/4/30.
//

#import "ModuleHomeController.h"
#import "ModuleCollectionViewCell.h"

@interface ModuleFuncation : NSObject

@property (nonatomic, strong) NSString * cellText;
@property (nonatomic, strong) NSString * viewControllerName;
@end

@implementation ModuleFuncation

@end

@interface ModuleHomeController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ModuleHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    NSLog(@"%s",__func__);
    self.homeTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    [self.view addSubview:self.homeTableView];
    
    // 初始化数据源
    self.dataSource = [NSMutableArray array];
    
    ModuleFuncation * redGitInfo = [[ModuleFuncation alloc] init];
    redGitInfo.viewControllerName = @"";
    redGitInfo.cellText = @"读取git信息";
    [self.dataSource addObject:redGitInfo];
    
    
    
    
    
//    return;
//
//    NSLog(@"haijie%d",HAIJIEVERSION);
//
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    layout.minimumLineSpacing = 5;
//    layout.minimumInteritemSpacing = 10;
//    //    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
//
//    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//
//    self.mainCollectionView.showsHorizontalScrollIndicator = NO;
//    self.mainCollectionView.showsVerticalScrollIndicator = NO;
//    [self.mainCollectionView registerClass:[ModuleCollectionViewCell class] forCellWithReuseIdentifier:@"ModuleCollectionViewCell"];
//    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
//    self.mainCollectionView.delegate   = self;
//    self.mainCollectionView.dataSource = self;
//    [self.view addSubview:self.mainCollectionView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ids"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ids"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ModuleFuncation * mFuncation = self.dataSource[indexPath.row];
    cell.textLabel.text = mFuncation.cellText;
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ModuleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ModuleCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

-(void) deleteContent:(NSIndexPath *)_indexPath{
    
    //Remove items from array on delete
    //    [itemArr removeObjectAtIndex:_indexPath.row];
    
    //Reload the items of UICollectionView performBatchUpdates Block
    [self.mainCollectionView performBatchUpdates:^{
        //        [self.mainCollectionView deleteItemsAtIndexPaths:@[_indexPath]];
    } completion:nil];
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"====%ld",indexPath.item);
    NSIndexPath *lIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    
    UICollectionViewCell *cell = [self.mainCollectionView cellForItemAtIndexPath:lIndexPath];
    
    
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    context = UIGraphicsGetCurrentContext();
    //    [UIView beginAnimations:nil context:context];
    //    [UIView setAnimationDuration:2];
    //    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cell cache:YES];
    //    [UIView commitAnimations];
    //
    //    //Implementation of GCD to delete a flip item
    //    double delay = 2/2;
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //        //code to be executed on the main queue after delay
    //        [self deleteContent:indexPath];
    //    });
    
    [UIView transitionWithView:cell duration:2 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cell.backgroundColor = [UIColor greenColor];
        });
    } completion:^(BOOL finished) {
        //        [self.mainCollectionView reloadData];
    }];
}


//集合视图单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat w = (self.view.bounds.size.width - 20) / 3;
    return CGSizeMake(w, 150);
}


@end
