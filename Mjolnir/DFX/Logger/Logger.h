//
//  Logger.h
//  Mjolnir
//
//  Created by 夏 小为 on 14/12/5.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaLumberjack.h"

#define Log         DDLogDebug
#define LogDebug    DDLogDebug

// 日志级别
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

@interface Logger : NSObject

+ (Logger *)defaultLogger;

- (void)start;

- (NSString *)currentLogFilePath;

@end