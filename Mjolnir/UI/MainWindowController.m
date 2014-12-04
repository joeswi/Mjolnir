//
//  MainWindowController.m
//  Mjolnir
//
//  Created by 夏 小为 on 14/12/4.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import "MainWindowController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

+ (MainWindowController *)sharedWindowController
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        
        NSWindow *window = [[NSWindow alloc] initWithContentRect:NSZeroRect
                                                       styleMask:NSTitledWindowMask|NSResizableWindowMask
                                                         backing:NSBackingStoreBuffered
                                                           defer:NO];
        _sharedObject = [[self alloc] initWithWindow:window];
        
    });
    return _sharedObject;
}

+ (void)showViewController:(NSViewController *)viewController
{
    NSWindowController *windowController = [self.class sharedWindowController];
    if ([NSApp keyWindow])
    {
        [NSApp beginSheet:[windowController window]
           modalForWindow:[NSApp keyWindow]
            modalDelegate:nil
           didEndSelector:nil
              contextInfo:NULL];
        [[windowController window] setContentViewController:viewController];
    }
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
