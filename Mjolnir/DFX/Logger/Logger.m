//
//  Logger.m
//  Mjolnir
//
//  Created by 夏 小为 on 14/12/5.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import "Logger.h"

@interface Logger ()

@property (nonatomic, strong) DDFileLogger *fileLogger;

@end

@implementation Logger

+ (Logger *)defaultLogger
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // 添加文件日志
        self.fileLogger = [[DDFileLogger alloc] init];
        self.fileLogger.rollingFrequency = 60 * 60 * 24;
        self.fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        [DDLog addLogger:self.fileLogger];
    }
    return self;
}

- (void)start
{
    [Logger defaultLogger];
}

- (NSString *)currentLogFilePath
{
    return [[self.fileLogger currentLogFileInfo] filePath];
}

@end
