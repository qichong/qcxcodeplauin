//
//  NSObject+MethodSwizzler.m
//  xcodepluinTest
//
//  Created by 齐冲 on 16/5/27.
//  Copyright © 2016年 齐冲. All rights reserved.
//

#import "NSObject+MethodSwizzler.h"
#import <objc/runtime.h>
@implementation NSObject (MethodSwizzler)
+ (void) swizzleWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector isClassMethod:(BOOL)isClassMethod{
    Class cls = [self class];
    Method originalMethod;
    Method swizzledMethod;
    if (isClassMethod) {
        originalMethod = class_getClassMethod(cls, originalSelector);
        swizzledMethod = class_getClassMethod(cls, swizzledSelector);
    }else{
        originalMethod = class_getInstanceMethod(cls, originalSelector);
        swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    }
    if (!originalMethod) {
        NSLog(@"Error:originalMethod is nil!");
        return;
    }
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end
