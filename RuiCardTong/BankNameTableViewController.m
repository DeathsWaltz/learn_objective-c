//
//  BankNameTableViewController.m
//  RuiCardTong
//
//  Created by waltzdeath on 16/1/3.
//  Copyright © 2016年 ztej. All rights reserved.
//

#import "BankNameTableViewController.h"

@interface BankNameTableViewController ()
{
    UITableView *bankNameView;
    NSArray *bankNameContext;
    TransferViewController *transferView;
    TransferCell *tCell;
}
@end
static NSString *cellIdentifier = @"titlecell";
@implementation BankNameTableViewController

- (void)viewDidLoad
{
    self.view.backgroundColor =  [UIColor whiteColor];
    
    [self main];
}

- (void)main
{
    bankNameView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    bankNameView.delegate = self;
    bankNameView.dataSource = self;
    bankNameView.bounces = NO;
    [self.view addSubview:bankNameView];
    
    bankNameContext = [[NSArray alloc]initWithObjects:@"中国建设银行",
                       @"中国农业银行",@"中国工商银行",@"中国招商银行",@"中国浦发银行",@"中国兴业银行",@"中国建设银行",
                       @"中国农业银行",@"中国工商银行",@"中国招商银行",@"中国浦发银行",@"中国兴业银行",@"中国建设银行",
                       @"中国农业银行",@"中国工商银行",@"中国招商银行",@"中国浦发银行",@"中国兴业银行",@"中国建设银行",
                       @"中国农业银行",@"中国工商银行",@"中国招商银行",@"中国浦发银行",@"中国兴业银行",@"中国建设银行",
                       @"中国农业银行",@"中国工商银行",@"中国招商银行",@"中国浦发银行",@"中国兴业银行", nil];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT/15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return bankNameContext.count;
}


#pragma mark - 设置TableView的响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //transferView = [[TransferViewController alloc] init];
    NSLog(@"====%ld",(long)indexPath.row);
    
    NSArray *viewCount = self.navigationController.viewControllers;
    _bankName = [NSString stringWithFormat:[bankNameContext objectAtIndex:indexPath.row]];
    
    [[tCell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 返回上一页
    [self.navigationController popToViewController:[viewCount objectAtIndex:1] animated:YES];
    
}

#pragma mark - 设置TableView的内容

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *title = [bankNameContext objectAtIndex:indexPath.row];
    
    cell.textLabel.text = title;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}
- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"ggg");
}

@end
