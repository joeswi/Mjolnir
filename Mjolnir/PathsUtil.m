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

+ (NSString *)currentWorkspacePath
{
    return [CCPWorkspaceManager currentWorkspaceDirectoryPath];
}

+ (NSString *)httpServiceMockPath
{
    return nil;
}

@end
