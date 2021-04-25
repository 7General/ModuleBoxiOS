//
//  ModuleHomeController.m
//  ModuleHome
//
//  Created by ZZG on 2020/4/30.
//

#import "ModuleHomeController.h"
#import "ModuleCollectionViewCell.h"
#import "ModuleGitInfoViewController.h"
#import "TTTT.h"
#import "ModulScrollViewController.h"
#import "ModuleEmptyViewController.h"


#define GZCMTI(schemem,positon) [NSString stringWithFormat:@"%@.%@",schemem,positon]

static NSString *const GZCMTI_HOME_GOLD_FIXED_BESEEN = @"c2c.ios.10.index.gold_fixed-fixed";

@interface ModuleFuncation : NSObject

@property (nonatomic, strong) NSString * cellText;
@property (nonatomic, strong) NSString * viewControllerName;
@end

@implementation ModuleFuncation

@end

@interface ModuleHomeController () <UITableViewDelegate,UITableViewDataSource>



@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIImage *images;

@property (nonatomic, strong) NSMutableArray *tempArray;

@end

@implementation ModuleHomeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // https://mikefighting.github.io/
    // 从1亿个数里面找出前100个最大的
    // https://www.jianshu.com/p/119c1ff5ea69
    
    
    NSLog(@"%s",__func__);
    self.homeTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    [self.view addSubview:self.homeTableView];
    
    
    self.tempArray = [NSMutableArray array];
    self.images = [UIImage imageNamed:@"tab_pressed_icon2"];
    
    
    // 初始化数据源
    self.dataSource = [NSMutableArray array];
    
    ModuleFuncation * redGitInfo = [[ModuleFuncation alloc] init];
    redGitInfo.viewControllerName = @"ModuleGitInfoViewController";
    redGitInfo.cellText = @"读取git信息";
    [self.dataSource addObject:redGitInfo];
    
    ModuleFuncation * base64Info = [[ModuleFuncation alloc] init];
    base64Info.viewControllerName = @"ModuleBase64ViewController";
    base64Info.cellText = @"base64读取图片信息(标准和非标准格式)";
    [self.dataSource addObject:base64Info];
    
    ModuleFuncation * collectionInfo = [[ModuleFuncation alloc] init];
    collectionInfo.viewControllerName = @"ModuleCollectionViewController";
    collectionInfo.cellText = @"UICollectionView的基本用法";
    [self.dataSource addObject:collectionInfo];
    
    ModuleFuncation *observerInfo = [[ModuleFuncation alloc] init];
    observerInfo.viewControllerName = @"ModuleMonitorViewController";
    observerInfo.cellText = @"主线程卡顿监控(美团)";
    [self.dataSource addObject:observerInfo];
    
    ModuleFuncation *mainExportInfo = [[ModuleFuncation alloc] init];
    mainExportInfo.viewControllerName = @"ModuleRAMExportViewController";
    mainExportInfo.cellText = @"冷启动优化-注册代码段";
    [self.dataSource addObject:mainExportInfo];
    
    ModuleFuncation *overrideInfo = [[ModuleFuncation alloc] init];
    overrideInfo.viewControllerName = @"ModuleMustOverrideViewController";
    overrideInfo.cellText = @"子类必须重写-MustOverride";
    [self.dataSource addObject:overrideInfo];
    
    ModuleFuncation *scrollView = [[ModuleFuncation alloc] init];
    scrollView.viewControllerName = @"ModulScrollViewController";
    scrollView.cellText = @"无限轮播";
    [self.dataSource addObject:scrollView];
    
    ModuleFuncation *editTableView = [[ModuleFuncation alloc] init];
    editTableView.viewControllerName = @"ModulEditTableViewController";
    editTableView.cellText = @"table编辑";
    [self.dataSource addObject:editTableView];
    
    [self.tempArray addObject:@"1"];
    NSLog(@"-----%@",self.tempArray);
    [self.tempArray addObject:@"2"];
    NSLog(@"-----%@",self.tempArray);
//
//    NSString *tt = [NSString stringWithFormat:@"%d",12];
//    NSString * mti = GZCMTI(GZCMTI_HOME_GOLD_FIXED_BESEEN, tt);
//    NSLog(@"--mti:%@",mti);
    
    
//    TTTT *ts = [[TTTT alloc] init];
////    [ts setCloseHandler:^{
////        NSLog(@"=======");
////    }];
//    [ts eeeeeeee:^{
//        NSLog(@"=======");
//    }];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)btnClick {
    ModuleEmptyViewController * scroll = [[ModuleEmptyViewController alloc] init];
    [self.navigationController pushViewController:scroll animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        [self test3];
}


- (void)test3 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 100; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%d",i);
        });
    }
    dispatch_barrier_async(queue, ^{
        NSLog(@"102");
    });
    dispatch_async(queue, ^{
        NSLog(@"103");
    });
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ModuleFuncation * mFuncation = self.dataSource[indexPath.row];
    UIViewController * viewController = [[NSClassFromString(mFuncation.viewControllerName) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    // 1
    // 2
    // 3
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}




@end
