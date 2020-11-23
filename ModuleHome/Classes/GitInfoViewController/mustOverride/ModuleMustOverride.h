//
//  ModuleMustOverride.h
//  ModuleHome
//
//  Created by ZZG on 2020/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Include this macro inside any class or instance method that MUST be overridden
 * by its subclass(es). The app will then crash immediately on launch with an
 * assertion if the method is not overridden (even if it is never called).
 */
#define SUBCLASS_MUST_OVERRIDE __attribute__((used, section("__DATA,MustOverride" \
))) static const char *__must_override_entry__ = __func__


NS_ASSUME_NONNULL_END
