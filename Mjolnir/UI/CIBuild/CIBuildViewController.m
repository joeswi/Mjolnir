//
//  CIBuildViewController.m
//  Mjolnir
//
//  Created by 夏 小为 on 14/12/4.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import "CIBuildViewController.h"
#import "PathsUtil.h"

@interface CIBuildViewController () <NSComboBoxDelegate, NSComboBoxDataSource>

@property (weak) IBOutlet NSComboBox *targetComboBox;

@property (nonatomic, strong) NSMutableArray *itemInfos;

@end

@implementation CIBuildViewController

- (IBAction)CancelButtonOnClicked:(id)sender
{
    [self dismiss];
}

- (IBAction)OKButtonOnClicked:(id)sender
{
    [self dismiss];
}


- (id)init
{
    self = [super init];
    if (self)
    {
        self.itemInfos = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.targetComboBox.delegate = self;
    self.targetComboBox.dataSource = self;
    
    
    [self fetchData];
    NSLog(@"========================");

    [self.targetComboBox selectItemAtIndex:0];
}

#pragma mark - NSComboBoxDataSource

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    return [self.itemInfos count];
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%@", self.itemInfos[index]];
}

#pragma mark - NSComboBoxDelegate

- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    
}

#pragma mark - Private

- (void)fetchData
{
    [self.itemInfos removeAllObjects];
    [self.itemInfos addObjectsFromArray:@[@"adhoc", @"appstore"]];
    [self.targetComboBox reloadData];
}

@end
