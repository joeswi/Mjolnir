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

+ (NSString *)httpServiceMock
{
    NSString *httpMockRoot = [[PathsUtil currentWorkspace] stringByAppendingPathComponent:@"HttpServiceMock"];
    return httpMockRoot;
}

+ (NSString *)httpServiceMockStartScript
{
    return [[PathsUtil httpServiceMockStartScriptBaseDir] stringByAppendingPathComponent:@"start.sh"];
}

+ (NSString *)httpServiceMockStartScriptBaseDir
{
    return [[PathsUtil httpServiceMock] stringByAppendingPathComponent:@"rbt"];
}

+ (NSString *)scriptLauncherScpt
{
    return @"/Users/xxw/Library/Application Support/Developer/Shared/Xcode/Plug-ins/Mjolnir.xcplugin/Contents/Resources/ScriptLauncher.scpt";
}

@end
