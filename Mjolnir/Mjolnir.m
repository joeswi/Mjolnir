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
#import "MainWindowController.h"
#import "CIBuildViewController.h"
#import "PathsUtil.h"
#import "Logger.h"


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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithBundle:(NSBundle *)plugin
{
    [[Logger defaultLogger] start];
    
    LogDebug(@"initWithBundle %@", plugin);
    
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
   
            // Mjolnir -> Http Mock
            NSMenuItem *httpMock = [[mjolnirMenu submenu] addItemWithTitle:@"HTTP Service Mock"
                                                                    action:@selector(httpMockMenuOnClick)
                                                             keyEquivalent:@""];
            httpMock.target = self;
            
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
            
            // Mjolnir -> Goto -> Mjolnir Console
            NSMenuItem *gotoMjolnirConsole = [[gotoMenu submenu] addItemWithTitle:@"Mjolnir Console"
                                                                           action:@selector(gotoMjolnirConsoleMenuOnClick)
                                                                    keyEquivalent:@""];
            gotoMjolnirConsole.target = self;
            
        }
    }
    return self;
}

- (void)httpMockMenuOnClick
{
    NSString *httpMockRoot = [PathsUtil httpServiceMock];
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:httpMockRoot isDirectory:&isDir] && isDir)
    {
        [[ScriptLauncher defaultLauncher] execute:@[[NSString stringWithFormat:@"cd %@", [PathsUtil httpServiceMockStartScriptBaseDir]],
                                                    [NSString stringWithFormat:@"sh %@", [PathsUtil httpServiceMockStartScript]]]];
    }
    else
    {
        [self showMessage:@"Error, Can't find http mock script"];
    }
}

- (void)ciBuildMenuOnClick
{
    CIBuildViewController *cibuild = [[CIBuildViewController alloc] init];
    [cibuild present];
}

- (void)analyzeMenuOnClick
{
    
}

- (void)gotoCIMenuOnClick
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://221.226.48.130:2424/jenkins"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

- (void)gotoCrashExplorerMenuOnClick
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://221.226.48.130:2424/CrashExplorer"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

- (void)gotoMjolnirConsoleMenuOnClick
{
    NSString *logFilePath = [[Logger defaultLogger] currentLogFilePath];
    LogDebug(@"Start MjolnirConsole...");
    LogDebug(@"logFilePath = %@", logFilePath);
    NSString *command = [NSString stringWithFormat:@"tail -f -n 500 \"%@\"", logFilePath];
    [[ScriptLauncher defaultLauncher] execute:@[command]];
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
