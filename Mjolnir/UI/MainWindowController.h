//
//  MainWindowController.h
//  Mjolnir
//
//  Created by 夏 小为 on 14/12/4.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainWindowController : NSWindowController

+ (MainWindowController *)sharedWindowController;

+ (void)showViewController:(NSViewController *)viewController;


@end
