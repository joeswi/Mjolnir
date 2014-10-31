//
//  Mjolnir.m
//  Mjolnir
//
//  Created by 夏 小为 on 14/10/31.
//    Copyright (c) 2014年 XXW. All rights reserved.
//

#import "Mjolnir.h"
#import "CCPShellHandler.h"

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
            
            // Mjolnir -> GotoCI
            NSMenuItem *goCI = [[mjolnirMenu submenu] addItemWithTitle:@"Goto CI"
                                                                action:@selector(gotoCIMenuOnClick)
                                                         keyEquivalent:@""];
            goCI.target = self;
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
    [CCPShellHandler runShellCommand:[[self gemPath]stringByAppendingPathComponent:POD_EXECUTABLE]
                            withArgs:@[@"install"]
                           directory:[CCPWorkspaceManager currentWorkspaceDirectoryPath]
                          completion: ^(NSTask *t) {
                              if ([self shouldInstallDocsForPods])
                                  [self installOrUpdateDocSetsForPods];
                          }];
}

- (void)gotoCIMenuOnClick
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://221.226.48.130:2424/Jenkins"];
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

@end
