//
//  RightViewController.m
//  RuiCardTong
//
//  Created by waltz on 15/12/8.
//  Copyright  2015 ztej. All rights reserved.
//

#import "RightViewController.h"


@interface RightViewController ()
{
    MoneyViewController *moneyView;
    TransactionRecordsViewController *transactionRecordsView;
    TransferViewController *transferView;
    FinancialViewController *financialView;
    ViewController *viewController;
    PersonageLoginViewController *personageLoginView;
    UIImage *rightImage;
    NSUserDefaults *userInfo;
    
    NSUserDefaults *info;
}
@property (strong, readwrite, nonatomic) UITableView *tableView;
@end

@implementation RightViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    
    userInfo = [NSUserDefaults standardUserDefaults];
    rightImage = [UIImage imageNamed:@"menu" ];
    
    info = [NSUserDefaults standardUserDefaults];
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
        {
            UIAlertView *notOpened = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此功能暂未开放" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [notOpened show];
            //[self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[SecondViewController alloc] init]]
                                                         //animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
        case 2:
            
            if ([userInfo objectForKey:@"userMoreInfo"] == nil) {
                personageLoginView =[[PersonageLoginViewController alloc] init];
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:personageLoginView]
                                                             animated:YES];
                personageLoginView.title = @"登录";
                personageLoginView.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
                personageLoginView.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
                //设置bar的背景为不透明，设置为蓝色，设置view的背景为白色
                personageLoginView.navigationController.navigationBar.translucent = NO;
                personageLoginView.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.32 green:0.53 blue:1 alpha:1];
                personageLoginView.navigationController.view.backgroundColor = [UIColor whiteColor];
                [self.sideMenuViewController hideMenuViewController];
                //[self.navigationController pushViewController:personageLoginView animated:YES];
            }else{
                moneyView = [[MoneyViewController alloc]init ];
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:moneyView]
                                                             animated:YES];
                moneyView.title = @"资产管理";
                moneyView.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
                moneyView.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
                //设置bar的背景为不透明，设置为蓝色，设置view的背景为白色
                moneyView.navigationController.navigationBar.translucent = NO;
                moneyView.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.32 green:0.53 blue:1 alpha:1];
                moneyView.navigationController.view.backgroundColor = [UIColor whiteColor];
                [self.sideMenuViewController hideMenuViewController];
            }

            
            break;
        case 3:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"此功能暂未开放" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancel];
            
            
            [self presentViewController:alertController animated:YES completion:nil];
           //transactionRecordsView = [[TransactionRecordsViewController alloc] init];
            //[self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:transactionRecordsView]
                                                            //animated:YES];
            transactionRecordsView.title = @"交易详情";
            transactionRecordsView.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
            transactionRecordsView.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
            //设置bar的背景为不透明，设置为蓝色，设置view的背景为白色
            transactionRecordsView.navigationController.navigationBar.translucent = NO;
            transactionRecordsView.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.32 green:0.53 blue:1 alpha:1];
            transactionRecordsView.navigationController.view.backgroundColor = [UIColor whiteColor];
            
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
        case 4:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"此功能暂未开放" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancel];
            
            
            [self presentViewController:alertController animated:YES completion:nil];
            //financialView = [[FinancialViewController alloc]init];
            //[self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:financialView]
                                                            //animated:YES];
            financialView.title = @"金融理财";
            financialView.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
            financialView.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
            //设置bar的背景为不透明，设置为蓝色，设置view的背景为白色
            financialView.navigationController.navigationBar.translucent = NO;
            financialView.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.32 green:0.53 blue:1 alpha:1];
            financialView.navigationController.view.backgroundColor = [UIColor whiteColor];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
        case 5:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"此功能暂未开放" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancel];
            
            
            [self presentViewController:alertController animated:YES completion:nil];
            //[self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[SecondViewController alloc] init]]
                                                        //animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
        case 6:
            NSLog(@"退出登录");
            
            UIAlertController *loginOut = [UIAlertController alertControllerWithTitle:@"提示" message:@"退出登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                if ([info objectForKey:@"info"] == nil) {
                    [self.sideMenuViewController hideMenuViewController];
                }else{
                    NSLog(@"确定");
                    info = [NSUserDefaults standardUserDefaults];
                    [info removeObjectForKey:@"info"];
                    [info synchronize];
                    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]]
                                                                 animated:YES];
                    [self.sideMenuViewController hideMenuViewController];
                }

            }];
            [loginOut addAction:cancel];
            [loginOut addAction:confirm];
            
            
            [self presentViewController:loginOut animated:YES completion:nil];
            
            
            //UIAlertView *loginOut = [[UIAlertView alloc] initWithTitle:@"退出登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            //[loginOut show];
            
            break;
    }
}
/*
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"取消");
    }else if(buttonIndex == 1)
    {
    }
}*/

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"首页", @"签到",@"资产管理",@"交易详情",@"金融理财",@"客服",@"退出登录"];
    cell.textLabel.text = titles[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    
    return cell;
}

@end
