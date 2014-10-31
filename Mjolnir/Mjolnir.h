//
//  Mjolnir.h
//  Mjolnir
//
//  Created by 夏 小为 on 14/10/31.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface Mjolnir : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end