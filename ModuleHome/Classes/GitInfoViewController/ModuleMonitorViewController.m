//
//  ModuleMonitorViewController.m
//  ModuleHome
//
//  Created by ZZG on 2020/11/13.
//

#import "ModuleMonitorViewController.h"

@interface ModuleMonitorViewController ()

@property (nonatomic, assign)BOOL * isMonitor;


@end

@implementation ModuleMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     1. 创建一个观察者runLoopObserver，用于观察主线程的runloop状态。
     2. 还要创建一个信号量dispatchSemaphore，用于保证同步操作。
     3. 将观察者runLoopObserver添加到主线程runloop中观察。
     4. 开启一个子线程，并且在子线程中开启一个持续的loop来监控主线程runloop的状态。
     5. 如果发现主线程runloop的状态卡在为BeforeSources或者AfterWaiting超过一定时间时，即表明主线程当前卡顿。
     */
    
}

//static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
//    MCXCatonMonitor *monitor = (__bridge MCXCatonMonitor*)info;
//    monitor->runLoopActivity = activity;
//
//    dispatch_semaphore_t semaphore = monitor->dispatchSemaphore;
//    dispatch_semaphore_signal(semaphore);
//}
//
//- (void)startMonitor {
//    self.isMonitoring = YES;
//    //监测卡顿
//    if (runLoopObserver) {
//        return;
//    }
//    dispatchSemaphore = dispatch_semaphore_create(0); //Dispatch Semaphore保证同步
//    //创建一个观察者
//    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
//    runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,
//                                              kCFRunLoopAllActivities,
//                                              YES,
//                                              0,
//                                              &runLoopObserverCallBack,
//                                              &context);
//    //将观察者添加到主线程runloop的common模式下的观察中
//    CFRunLoopAddObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
//
//    //创建子线程监控
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        //子线程开启一个持续的loop用来进行监控
//        while (YES) {
//            long semaphoreWait = dispatch_semaphore_wait(self->dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, kMCXCatonMonitorDuration * NSEC_PER_MSEC));
//            if (semaphoreWait != 0) {
//                if (!self->runLoopObserver) {
//                    self->timeoutCount = 0;
//                    self->dispatchSemaphore = 0;
//                    self->runLoopActivity = 0;
//                    return;
//                }
//                //两个runloop的状态，BeforeSources和AfterWaiting这两个状态区间时间能够检测到是否卡顿
//                if (self->runLoopActivity == kCFRunLoopBeforeSources || self->runLoopActivity == kCFRunLoopAfterWaiting) {
//                    //出现三次出结果
//                    if (++self->timeoutCount < kMCXCatonMonitorMaxCount) {
//                        continue;
//                    }
//                    //进行堆栈记录保存
//
//                } //end activity
//            }// end semaphore wait
//            self->timeoutCount = 0;
//        }// end while
//    });
//}


@end
