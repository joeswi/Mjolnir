//
//  Mjolnir.m
//  Mjolnir
//
//  Created by 夏 小为 on 14/10/31.
//    Copyright (c) 2014年 XXW. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "Mjolnir.h"
#import "ScriptLauncher.h"
#import "CCPShellHandler.h"
#import "CCPWorkspaceManager.h"

static Mjolnir *sharedPlugin;

@interface Mjolnir() 

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation Mjolnir

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        
        // Create menu items, initialize UI, etc.
        NSMenuItem *productMenu = [[NSApp mainMenu] itemWithTitle:@"Product"];
        if (productMenu)
        {
            [[productMenu submenu] addItem:[NSMenuItem separatorItem]];
            
            // Main Menu: Mjolnir
            NSMenuItem *mjolnirMenu = [[productMenu submenu] addItemWithTitle:@"Mjolnir"
                                                                       action:nil
                                                                keyEquivalent:@""];
            mjolnirMenu.submenu = [[NSMenu alloc] initWithTitle:@"Mjolnir"];
            
            // Mjolnir -> Http Mock
            NSMenuItem *httpMock = [[mjolnirMenu submenu] addItemWithTitle:@"Http Mock"
                                                                    action:@selector(httpMockMenuOnClick)
                                                             keyEquivalent:@""];
            httpMock.target = self;
            
            // Mjolnir -> CIBuild
            NSMenuItem *cibuild = [[mjolnirMenu submenu] addItemWithTitle:@"CIBuild"
                                                                   action:@selector(ciBuildMenuOnClick)
                                                            keyEquivalent:@""];
            cibuild.target = self;
            
            // Mjolnir -> Analyze
            NSMenuItem *analyze = [[mjolnirMenu submenu] addItemWithTitle:@"Consistency Analyze"
                                                                   action:@selector(analyzeMenuOnClick)
                                                            keyEquivalent:@""];
            analyze.target = self;
            
            
            // Mjolnir -> Goto
            NSMenuItem *gotoMenu = [[mjolnirMenu submenu] addItemWithTitle:@"Goto" action:nil keyEquivalent:@""];
            gotoMenu.submenu = [[NSMenu alloc] initWithTitle:@"Goto"];
            
            
            // Mjolnir -> Goto -> Continuous Integration
            NSMenuItem *gotoCI = [[gotoMenu submenu] addItemWithTitle:@"Continuous Integration"
                                                                action:@selector(gotoCIMenuOnClick)
                                                         keyEquivalent:@""];
            gotoCI.target = self;
            
            // Mjolnir -> Goto -> Crash Explorer
            NSMenuItem *gotoCrashExplorer = [[gotoMenu submenu] addItemWithTitle:@"Crash Explorer"
                                                               action:@selector(gotoCrashExplorerMenuOnClick)
                                                        keyEquivalent:@""];
            gotoCrashExplorer.target = self;
        }
    }
    return self;
}

- (void)mjolnirMenuOnClick
{
    
}

- (void)httpMockMenuOnClick
{
    
}

- (void)ciBuildMenuOnClick
{
    
}

- (void)analyzeMenuOnClick
{
    
    
//    NSString *cibuildRoot = [[CCPWorkspaceManager currentWorkspaceDirectoryPath] stringByAppendingPathComponent:@"CIBuild"];
//    BOOL isDir = NO;
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cibuildRoot isDirectory:&isDir])
//    {
//        if (isDir)
//        {
//            [self showMessage:cibuildRoot];
//            [CCPShellHandler runShellCommand:[cibuildRoot stringByAppendingPathComponent:@"xcpa.py"]
//                                    withArgs:@[@""]
//                                   directory:cibuildRoot
//                                  completion: ^(NSTask *t) {
//                                      [self showMessage:t.description];
//                                  }];
//            return;
//        }
//    }
    
    NSString *cibuildRoot = [[CCPWorkspaceManager currentWorkspaceDirectoryPath] stringByAppendingPathComponent:@"HttpServiceMock"];
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:cibuildRoot isDirectory:&isDir])
    {
        if (isDir)
        {
            [self showMessage:[cibuildRoot stringByAppendingPathComponent:@"rbt/start.sh"]];
            [CCPShellHandler runShellCommand:@"/bin/sh"
                                    withArgs:@[[cibuildRoot stringByAppendingPathComponent:@"rbt/start.sh"]]
                                   directory:[cibuildRoot stringByAppendingPathComponent:@"rbt"]
                                  completion: ^(NSTask *t) {
                                      [self showMessage:t.description];
                                  }];
            return;
        }
    }

    [self showMessage:@"error"];
}

- (void)gotoCIMenuOnClick
{
    [[ScriptLauncher defaultLauncher] execute:@"cd /; ls"];
    
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://221.226.48.130:2424/jenkins"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

- (void)gotoCrashExplorerMenuOnClick
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://221.226.48.130:2424/CrashExplorer"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    NSAlert *alert = [NSAlert alertWithMessageText:@"Hello, World" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
    [alert runModal];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showMessage:(NSString *)message
{
    NSAlert *alert = [NSAlert alertWithMessageText:message
                                     defaultButton:nil
                                   alternateButton:nil
                                       otherButton:nil
                         informativeTextWithFormat:@""];
    [alert runModal];
}

@end
