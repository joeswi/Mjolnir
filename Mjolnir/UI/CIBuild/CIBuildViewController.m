//
//  CIBuildViewController.m
//  Mjolnir
//
//  Created by 夏 小为 on 14/12/4.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import "CIBuildViewController.h"
#import "PathsUtil.h"
#import "Logger.h"

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

- (void)viewDidInit
{
    [super viewDidInit];
    
    self.itemInfos = [NSMutableArray array];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.targetComboBox.delegate = self;
    self.targetComboBox.dataSource = self;
    
    [self fetchData];
}

#pragma mark - NSComboBoxDataSource

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    LogDebug(@"CIBuildViewController|numberOfItemsInComboBox, aComboBox = %@", aComboBox);
    return [self.itemInfos count];
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    LogDebug(@"CIBuildViewController|comboBox:objectValueForItemAtIndex, aComboBox = %@, index = %ld", aComboBox, index);
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
    if ([self.itemInfos count] > 0)
    {
        [self.targetComboBox selectItemAtIndex:0];
    }
}

@end
