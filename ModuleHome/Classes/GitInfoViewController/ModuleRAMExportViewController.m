//
//  ModuleRAMExportViewController.m
//  ModuleHome
//
//  Created by ZZG on 2020/11/16.
//

// https://www.cnblogs.com/yuxiaoyiyou/p/13518968.html
#import "ModuleRAMExportViewController.h"
#import "RAMExport.h"

// eventType 入参表示函数对应触发的条件
// 定义一个全局函数，声明不被优化，存储到mach-o的section信息中
// 如下存储的参数名为(eventType连接Func)，后期根据此名称取值
#define HF_Init_Func_For(eventType) \
static void HF_Func_##eventType(void); \
__attribute__((used, section("__DATA," ""#eventType "Func"))) \
static const void * __Func__##eventType = HF_Func_##eventType; \
static void HF_Func_##eventType(void)



@interface ModuleRAMExportViewController ()

@end

@implementation ModuleRAMExportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton * exportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exportButton.frame = CGRectMake(100, 100, 200, 40);
    [exportButton setTitle:@"冷启动调用函数" forState:UIControlStateNormal];
    exportButton.backgroundColor = [UIColor redColor];
    [exportButton addTarget:self action:@selector(exportClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exportButton];
}

- (void)exportClick {
    NSLog(@"开始执行A段代码");
//    [[RAMExport sharedInstance] executeBlockForKey:@"A"];
    [[RAMExport sharedInstance] executeArrayForKey:@"A"];
   
}
HF_Init_Func_For(setup){
       NSLog(@"============================");
}

//HF_Call_Func_For_([NSString stringWithFormat:@"%@Func",@"setup"]);
//
//int HF_Call_Func_For_(NSString *eventType) {
//    
//    Dl_info info;
//    dladdr((const void *)&HF_Call_Func_For_, &info);
//    struct mach_header_64 * machOHeader = (DTBaseMachHeader *)info.dli_fbase;
//    uint64_t mach_header = (DTBaseType)info.dli_fbase;
//    const struct section_64 * section = getsectbynamefromheader_64(machOHeader, "__DATA", eventType.UTF8String);
//    if (section == NULL) { return -1; }
//    size_t size = sizeof(void*);
//    for (uint64_t add = mach_header + section->offset; add < mach_header + section->offset + section->size ; add += size) {
//　　　　// 注意此处返回为指向函数指针（结构体、基本数据结构等）的指针值
//        void (**function)(void) = (void (**)(void))add;
//        (*function)();
//    }
//    
//    return 0;
//}


@end
