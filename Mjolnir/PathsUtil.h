//
//  DirectoryUtil.h
//  Mjolnir
//
//  Created by 夏 小为 on 14/12/4.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathsUtil : NSObject

+ (NSString *)currentWorkspace;

#pragma mark - CIBuild Path

+ (NSString *)ciBuild;

+ (NSString *)ciBuildScript;

+ (NSString *)ciBuildSettings;

+ (NSString *)ciBuildUpdate;

#pragma mark - Http Service Mock Path

+ (NSString *)httpServiceMock;

+ (NSString *)httpServiceMockStartScript;

+ (NSString *)httpServiceMockStartScriptBaseDir;

#pragma mark - Script Launcher Path

+ (NSString *)scriptLauncherScpt;

@end
