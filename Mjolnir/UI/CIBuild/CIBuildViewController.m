//
//  CIBuildViewController.m
//  Mjolnir
//
//  Created by 夏 小为 on 14/12/4.
//  Copyright (c) 2014年 XXW. All rights reserved.
//

#import "CIBuildViewController.h"

@interface CIBuildViewController () <NSComboBoxDelegate, NSComboBoxDataSource>

@property (weak) IBOutlet NSComboBox *targetComboBox;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.targetComboBox.delegate = self;
    self.targetComboBox.dataSource = self;
    [self.targetComboBox selectItemAtIndex:0];
}

#pragma mark - NSComboBoxDataSource

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    return 3;
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%ld", index];
}

#pragma mark - NSComboBoxDelegate

- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    
}

@end
