//
//  NSObject+MethodSwizzler.h
//  xcodepluinTest
//
//  Created by 齐冲 on 16/5/27.
//  Copyright © 2016年 齐冲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MethodSwizzler)
+ (void) swizzleWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector isClassMethod:(BOOL)isClassMethod;
@end
