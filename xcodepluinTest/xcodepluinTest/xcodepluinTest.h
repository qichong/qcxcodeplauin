//
//  xcodepluinTest.h
//  xcodepluinTest
//
//  Created by 齐冲 on 16/5/24.
//  Copyright © 2016年 齐冲. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface xcodepluinTest : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end