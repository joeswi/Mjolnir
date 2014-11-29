//
//  ScriptLauncher.m
//  Mjolnir
//
//  Created by 夏 小为 on 14/11/29.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import "ScriptLauncher.h"

#define ScriptLauncherScpt  @"/Users/xxw/Library/Application Support/Developer/Shared/Xcode/Plug-ins/Mjolnir.xcplugin/Contents/Resources/ScriptLauncher.scpt"

@implementation ScriptLauncher

+ (ScriptLauncher *)defaultLauncher
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (void)execute:(NSString *)cmd
{
    NSString *osascript = ScriptLauncherScpt;
    if (osascript)
    {
        NSTask *task = [NSTask launchedTaskWithLaunchPath:@"/usr/bin/osascript"
                                                arguments:@[osascript, cmd]];
        [task waitUntilExit];
    }
}

@end
