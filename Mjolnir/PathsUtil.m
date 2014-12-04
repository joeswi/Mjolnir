//
//  DirectoryUtil.m
//  Mjolnir
//
//  Created by 夏 小为 on 14/12/4.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import "PathsUtil.h"
#import "CCPWorkspaceManager.h"

@implementation PathsUtil

+ (NSString *)currentWorkspace
{
    return [CCPWorkspaceManager currentWorkspaceDirectoryPath];
}

#pragma mark - CIBuild Path

+ (NSString *)ciBuild
{
    return [[PathsUtil currentWorkspace] stringByAppendingPathComponent:@"CIBuild"];
}

+ (NSString *)ciBuildScript
{
    return [[PathsUtil ciBuild] stringByAppendingPathComponent:@"cibuild.py"];
}

+ (NSString *)ciBuildSettings
{
    return [[PathsUtil ciBuild] stringByAppendingPathComponent:@"settings.py"];
}

+ (NSString *)ciBuildUpdate
{
    return [[PathsUtil ciBuild] stringByAppendingPathComponent:@"update.py"];
}

#pragma mark - Http Service Mock Path

+ (NSString *)httpServiceMock
{
    return [[PathsUtil currentWorkspace] stringByAppendingPathComponent:@"HttpServiceMock"];
}

+ (NSString *)httpServiceMockStartScript
{
    return [[PathsUtil httpServiceMockStartScriptBaseDir] stringByAppendingPathComponent:@"start.sh"];
}

+ (NSString *)httpServiceMockStartScriptBaseDir
{
    return [[PathsUtil httpServiceMock] stringByAppendingPathComponent:@"rbt"];
}

#pragma mark - Script Launcher Path

+ (NSString *)scriptLauncherScpt
{
    return @"/Users/xxw/Library/Application Support/Developer/Shared/Xcode/Plug-ins/Mjolnir.xcplugin/Contents/Resources/ScriptLauncher.scpt";
}

@end
