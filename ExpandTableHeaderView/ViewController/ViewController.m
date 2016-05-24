//
//  ViewController.m
//  ExpandTableHeaderView
//
//  Created by bingyu on 16/5/24.
//  Copyright © 2016年 AVIC. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"

#define ScreenSize                  [UIScreen mainScreen].bounds.size
#define HeaderViewHeight            160

#define CellIdentifier              @"CellIdentifier"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) HeaderView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self initView];
}

- (void)initView {
    _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, HeaderViewHeight) withTableView:_tableView];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)(indexPath.row + 1)];
    
    return cell;
}

@end
