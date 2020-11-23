//
//  ModuleMustOverride.m
//  ModuleHome
//
//  Created by ZZG on 2020/11/19.
//

#import "ModuleMustOverride.h"

#if DEBUG

#import <dlfcn.h>
#import <mach-o/getsect.h>
#import <mach-o/dyld.h>
#import <objc/runtime.h>

@interface ModuleMustOverride : NSObject

@end

#ifdef __LP64__
typedef uint64_t MustOverrideValue;
typedef struct section_64 MustOverrideSection;
#define GetSectByNameFromHeader getsectbynamefromheader_64
#else
typedef uint32_t MustOverrideValue;
typedef struct section MustOverrideSection;
#define GetSectByNameFromHeader getsectbynamefromheader
#endif

@implementation ModuleMustOverride

static BOOL ClassOverridesMethod(Class cls, SEL selector)
{
    unsigned int numberOfMethods;
    Method *methods = class_copyMethodList(cls, &numberOfMethods);
    for (unsigned int i = 0; i < numberOfMethods; i++) {
        if (method_getName(methods[i]) == selector) {
            free(methods);
            return YES;
        }
    }
    free(methods);
    return NO;
}

static NSArray *SubclassesOfClass(Class baseClass)
{
    static Class *classes;
    static unsigned int classCount;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      classes = objc_copyClassList(&classCount);
    });

    NSMutableArray *subclasses = [NSMutableArray array];
    for (unsigned int i = 0; i < classCount; i++) {
        Class cls = classes[i];
        Class superclass = cls;
        while (superclass) {
            if (superclass == baseClass) {
                [subclasses addObject:cls];
                break;
            }
            superclass = class_getSuperclass(superclass);
        }
    }
    return subclasses;
}

static void CheckOverrides(void)
{
    Dl_info info;
    dladdr((const void *)&CheckOverrides, &info);

    const MustOverrideValue mach_header = (MustOverrideValue)info.dli_fbase;
    const MustOverrideSection *section = GetSectByNameFromHeader((void *)mach_header, "__DATA", "MustOverride");
    if (section == NULL) return;

    NSMutableArray *failures = [NSMutableArray array];
    for (MustOverrideValue addr = section->offset; addr < section->offset + section->size; addr += sizeof(const char **)) {
        NSString *entry = @(*(const char **)(mach_header + addr));
        NSArray *parts = [[entry substringWithRange:NSMakeRange(2, entry.length - 3)] componentsSeparatedByString:@" "];
        NSString *className = parts[0];
        NSRange categoryRange = [className rangeOfString:@"("];
        if (categoryRange.length) {
            className = [className substringToIndex:categoryRange.location];
        }

        BOOL isClassMethod = [entry characterAtIndex:0] == '+';
        Class cls = NSClassFromString(className);
        SEL selector = NSSelectorFromString(parts[1]);
        for (Class subclass in SubclassesOfClass(cls)) {
            if (!ClassOverridesMethod(isClassMethod ? object_getClass(subclass) : subclass, selector)) {
                [failures addObject:[NSString stringWithFormat:@"%@ does not implement method %c%@ required by %@",
                                     subclass, isClassMethod ? '+' : '-', parts[1], className]];
            }
        }
    }

    NSCAssert(failures.count == 0, @"%@%@",
              failures.count > 1 ? [NSString stringWithFormat:@"%zd method override errors:\n", failures.count] : @"",
              [failures componentsJoinedByString:@"\n"]);
}

+ (void)load {
    CheckOverrides();
}

@end

#endif
