//
//  ScriptLauncher.h
//  Mjolnir
//
//  Created by 夏 小为 on 14/11/29.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScriptLauncher : NSObject

+ (ScriptLauncher *)defaultLauncher;

- (void)execute:(NSString *)cmd;

@end
