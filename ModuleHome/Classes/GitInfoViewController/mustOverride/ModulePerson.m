//
//  ModulePerson.m
//  ModuleHome
//
//  Created by ZZG on 2020/11/19.
//

#import "ModulePerson.h"
#import "ModuleMustOverride.h"

@implementation ModulePerson


- (void)someMethod {
    NSLog(@"父类方法的名称:%s",__func__);
    SUBCLASS_MUST_OVERRIDE;
}
@end
