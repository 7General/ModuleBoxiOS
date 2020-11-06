//
//  ModuleHomeController.m
//  ModuleHome
//
//  Created by ZZG on 2020/4/30.
//

#import "ModuleHomeController.h"
#import "ModuleCollectionViewCell.h"
#import "ModuleGitInfoViewController.h"

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

@end

@implementation ModuleHomeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s",__func__);
    self.homeTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    [self.view addSubview:self.homeTableView];
    
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
