//
//  NSObject+xcodeMessage.m
//  xcodepluinTest
//
//  Created by 齐冲 on 16/5/27.
//  Copyright © 2016年 齐冲. All rights reserved.
//

#import "NSObject+xcodeMessage.h"
#import "NSObject+MethodSwizzler.h"
#import <AppKit/AppKit.h>
#import "xcodepluinTest.h"

@implementation NSObject (xcodeMessage)

- (id)qc_initWithIcon:(id)icon
               message:(NSString *)message
          parentWindow:(id)parentWindow
              duration:(double)duration {
    if (icon) {
        if ([self isKindOfClass:[NSPanel class]]) {
            if ([message containsString:@"Succeeded"]) {
                NSImage *image = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://upload-images.jianshu.io/upload_images/851246-a3904adc5fb61beb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
                
                [self qc_initWithIcon:image message:@"6666" parentWindow:parentWindow duration:duration];
                image.template = NO;
                
                if ([((NSPanel *)self).contentView isKindOfClass:[NSVisualEffectView class]]) {
                    ((NSVisualEffectView *)((NSPanel *)self).contentView).material =  NSVisualEffectBlendingModeWithinWindow;
                }
            }
            else if ([message containsString:@"Failed"]){
                            NSImage *image = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://upload-images.jianshu.io/upload_images/851246-bd34b4ff832775c6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];

                [self qc_initWithIcon:image message:@"fuck!" parentWindow:parentWindow duration:duration];
                image.template = NO;
                
                if ([((NSPanel *)self).contentView isKindOfClass:[NSVisualEffectView class]]) {
                    ((NSVisualEffectView *)((NSPanel *)self).contentView).material =  NSVisualEffectBlendingModeWithinWindow;
                }
            }
            else{
                return [self qc_initWithIcon:icon message:message parentWindow:parentWindow duration:duration];
            }
        }
        return self;
    }
    return [self qc_initWithIcon:icon message:message parentWindow:parentWindow duration:duration];
}

@end
