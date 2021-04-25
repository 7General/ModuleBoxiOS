//
//  ModuleGitInfoViewController.m
//  ModuleHome
//
//  Created by ZZG on 2020/10/15.
//

#import "ModuleGitInfoViewController.h"


@interface GITINFOMODULE : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;

- (instancetype)initWithTitlte:(NSString *)title value:(NSString *)value;

@end

@implementation GITINFOMODULE

- (instancetype)initWithTitlte:(NSString *)title value:(NSString *)value {
    self = [super init];
    if (self) {
        self.title = title;
        self.value = value;
    }
    return  self;
}


@end

@interface ModuleGitInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *GITTABLEVIEW;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ModuleGitInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"读取git信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    
    self.GITTABLEVIEW = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.GITTABLEVIEW.delegate = self;
    self.GITTABLEVIEW.dataSource = self;
    [self.view addSubview:self.GITTABLEVIEW];
    
    self.dataSource = [NSMutableArray array];
    
    GITINFOMODULE * builderModule = [[GITINFOMODULE alloc] initWithTitlte:@"Builder" value:GZ_PACKAGE_BUILDER];
    [self.dataSource addObject:builderModule];
    
    GITINFOMODULE * envModule = [[GITINFOMODULE alloc] initWithTitlte:@"env" value:GZ_PACKAGE_ENV];
    [self.dataSource addObject:envModule];
    
    GITINFOMODULE * packageModule = [[GITINFOMODULE alloc] initWithTitlte:@"Package ID" value:GZ_PACKAGE_ID];
    [self.dataSource addObject:packageModule];
    
    GITINFOMODULE * CODEModule = [[GITINFOMODULE alloc] initWithTitlte:@"Code ID" value:GZ_CODE_IDENTIFIER];
    [self.dataSource addObject:CODEModule];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ids"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ids"];
    }
    GITINFOMODULE * module = self.dataSource[indexPath.row];
    cell.textLabel.text = module.title;
    cell.detailTextLabel.text = module.value;
    return cell;
}

- (void)goBack {
    NSLog(@"---");
}


@end
