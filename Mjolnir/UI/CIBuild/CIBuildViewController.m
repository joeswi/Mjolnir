//
//  CIBuildViewController.m
//  Mjolnir
//
//  Created by 夏 小为 on 14/12/4.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import "CIBuildViewController.h"

@interface CIBuildViewController ()

@end

@implementation CIBuildViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass(self.class) bundle:[NSBundle bundleForClass:[self class]]];
    if (self)
    {
        [self.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

@end
