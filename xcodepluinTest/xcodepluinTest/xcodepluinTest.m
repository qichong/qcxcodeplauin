//
//  xcodepluinTest.m
//  xcodepluinTest
//
//  Created by 齐冲 on 16/5/24.
//  Copyright © 2016年 齐冲. All rights reserved.
//

#import "xcodepluinTest.h"
#import "NSObject+MethodSwizzler.h"

static xcodepluinTest *sharedPlugin;

@interface xcodepluinTest()
{
    NSMutableArray *arrary;
}
@property (nonatomic,assign)BOOL isDefault;
@end
@implementation xcodepluinTest

#pragma mark - Initialization

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    NSArray *allowedLoaders = [plugin objectForInfoDictionaryKey:@"me.delisa.XcodePluginBase.AllowedLoaders"];
    if ([allowedLoaders containsObject:[[NSBundle mainBundle] bundleIdentifier]]) {
        sharedPlugin = [[self alloc] initWithBundle:plugin];
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)bundle
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        _bundle = bundle;
        // NSApp may be nil if the plugin is loaded from the xcodebuild command line tool
        if (NSApp && !NSApp.mainMenu) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationDidFinishLaunching:)
                                                         name:NSApplicationDidFinishLaunchingNotification
                                                       object:nil];
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:nil object:nil];
            arrary = @[].mutableCopy;
//            self.isDefault =  [[NSUserDefaults standardUserDefaults] boolForKey:@"isdefault"];

//            [NSClassFromString(@"DVTBezelAlertPanel") swizzleWithOriginalSelector:@selector(initWithIcon:message:parentWindow:duration:) swizzledSelector:@selector(qc_initWithIcon:message:parentWindow:duration:) isClassMethod:NO];
            
//            if (self.isDefault) {
                [NSClassFromString(@"DVTBezelAlertPanel") swizzleWithOriginalSelector:@selector(qc_initWithIcon:message:parentWindow:duration:) swizzledSelector:@selector(initWithIcon:message:parentWindow:duration:) isClassMethod:NO];
//            }
//            else{
//                [NSClassFromString(@"DVTBezelAlertPanel") swizzleWithOriginalSelector:@selector(initWithIcon:message:parentWindow:duration:) swizzledSelector:@selector(qc_initWithIcon:message:parentWindow:duration:) isClassMethod:NO];
//            }

        } else {
            [self initializeAndLog];
        }
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];

    [self initializeAndLog];
}

//- (void)test:(NSNotification *)notification{
//    if (![arrary containsObject:notification.name]) {
//        NSLog(@"----> %@",notification.name);
//        if ((BOOL)[notification.name  isEqualToString:@"NSWindowWillOrderOffScreenNotification"]) {
////            ;
//////            [notification.name isEqualToString:@"NSWindowWillOrderOffScreenNotification"];
////            NSLog(@"----->>>%@",notification.object);
//            
//        }
//        [arrary addObject:notification.name];
//    }
//    
//}

- (void)initializeAndLog
{
    NSString *name = [self.bundle objectForInfoDictionaryKey:@"CFBundleName"];
    NSString *version = [self.bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *status = [self initialize] ? @"loaded successfully" : @"failed to load";
    NSLog(@"🔌 Plugin %@ %@ %@", name, version, status);
}

#pragma mark - Implementation

- (BOOL)initialize
{
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle: @"Deflaut notice" action:@selector(doMenuAction :) keyEquivalent:@""];
        //[actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
        return YES;
    } else {
        return NO;
    }
}

// Sample Action, for menu item:
- (void)doMenuAction :(NSMenuItem *)menuItem
{
//    NSAlert *alert = [[NSAlert alloc] init];
//    //    [NSAlert alertWithError:@"testerror!"];
//    [alert setMessageText:@"arrary remove success!"];
//    [alert runModal];
    self.isDefault = !self.isDefault;
    if (self.isDefault) {
        [NSClassFromString(@"DVTBezelAlertPanel") swizzleWithOriginalSelector:@selector(qc_initWithIcon:message:parentWindow:duration:) swizzledSelector:@selector(initWithIcon:message:parentWindow:duration:) isClassMethod:NO];
    }
    else{
        [NSClassFromString(@"DVTBezelAlertPanel") swizzleWithOriginalSelector:@selector(initWithIcon:message:parentWindow:duration:) swizzledSelector:@selector(qc_initWithIcon:message:parentWindow:duration:) isClassMethod:NO];
    }
    menuItem.title = self.isDefault ? @"fly" :@"Deflaut notice";
//
}

@end
