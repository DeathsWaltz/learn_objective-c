//
//  AccountBalanceViewController.m
//  RuiCardTong
//
//  Created by waltzdeath on 16/1/11.
//  Copyright © 2016年 ztej. All rights reserved.
//

#import "AccountBalanceViewController.h"

@interface AccountBalanceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *accountBalanceContextView;
    
    NSArray *accountBalanceLeftContext;
    NSArray *accountBalanceRightContext;
    UITableViewCell *cell;
    NSUserDefaults *info;
    
    
    NSDictionary *namePassword;
    
    NSDictionary *userInfo;
    
    NSDictionary *userData;
}

@end
static NSString *cellIdentifier = @"Cell";

@implementation AccountBalanceViewController

- (void)viewDidLoad {
    
    info = [NSUserDefaults standardUserDefaults];
    namePassword = [info objectForKey:@"info"];
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self main];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
#pragma mark - 主视图
- (void)main
{
    //添加Tableview
    [self addTableView];
    // 添加最近三次的账单纪录
    [self addTransactionRecords];
   

}
- (void)getUserDate
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://localhost:8081/ztcms/mobile/userLogin" parameters:namePassword success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue] == 1) {
            userInfo = responseObject;
            userData = [userInfo objectForKey:@"data"];
            
            
            
            
            
            NSLog(@"=%@",responseObject);
        }else{
            
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"失败");
    }];
    
}

#pragma mark - TabelViwe视图
- (void)addTableView
{
    [self getUserDate];
    accountBalanceContextView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3.7) style:UITableViewStylePlain];
    accountBalanceContextView.bounces = NO;
    accountBalanceContextView.delegate = self;
    accountBalanceContextView.dataSource = self;
    //accountBalanceContextView.layer.borderWidth = 1;
    //accountBalanceContextView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:accountBalanceContextView];
    accountBalanceLeftContext = [[NSArray alloc]initWithObjects:@"余额",
                                 @"充值",@"提现",@"账单", nil];
    accountBalanceRightContext = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@ 元",[userData objectForKey:@"balance"]],
                                  @"银行卡充值无手续费",@"银行卡提现无手续费",@"", nil];

    
}


#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT/15;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return [accountBalanceLeftContext count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}



#pragma mark - 设置TableView的响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //transferView = [[TransferViewController alloc] init];
    NSLog(@"====%ld",(long)indexPath.row);
    
    //NSArray *viewCount = self.navigationController.viewControllers;
    // 返回上一页
    //[self.navigationController popToViewController:[viewCount objectAtIndex:1] animated:YES];
   
    
}

#pragma mark - 设置TableView的内容

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellAccessoryDisclosureIndicator reuseIdentifier:cellIdentifier];
    }
    NSString *title = [accountBalanceLeftContext objectAtIndex:indexPath.row];
    NSString *context = [accountBalanceRightContext objectAtIndex:indexPath.row];
    
    switch (indexPath.row) {
        case 0:
           // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = title;
            cell.detailTextLabel.text = context;
            cell.detailTextLabel.textColor = [UIColor colorWithRed:0.25 green:0.68 blue:1 alpha:1];
            break;
            
        case 1:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = title;
            
            cell.detailTextLabel.text = context;
            break;

        case 2:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = title;
            
            cell.detailTextLabel.text = context;
            break;

        case 3:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = title;
            
            
            break;
            
            
    }
    
    
    
    
    
    return cell;
}
// 最近三次三次账单记录
- (void)addTransactionRecords
{
    UILabel *transactionRecords = [[UILabel alloc]initWithFrame:CGRectMake(20, accountBalanceContextView.frame.size.height+10, SCREEN_WIDTH, SCREEN_HEIGHT/50)];
    transactionRecords.text = @"最近三次账单纪录";
    transactionRecords.font = [UIFont systemFontOfSize:transactionRecords.frame.size.height];
    [self.view addSubview:transactionRecords];
    
    
    UIView *transactionRecordsDetails = [[UIView alloc] initWithFrame:CGRectMake(20, accountBalanceContextView.frame.size.height+transactionRecords.frame.size.height+20, SCREEN_WIDTH-40, SCREEN_HEIGHT/3.5)];
    //transactionRecordsDetails.layer.borderColor = [UIColor blackColor].CGColor;
    //transactionRecordsDetails.layer.borderWidth = 1;
    [self.view addSubview:transactionRecordsDetails];
    
    UIView *firstDetails = [[UIView alloc] initWithFrame:CGRectMake(0, 0, transactionRecordsDetails.frame.size.width, transactionRecordsDetails.frame.size.height/3.3)];
    firstDetails.layer.borderWidth = 1;
    firstDetails.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1].CGColor;
    
    UILabel *transactionMoney = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, firstDetails.frame.size.width/3, firstDetails.frame.size.height/3)];
    transactionMoney.text = @"+300元";
    transactionMoney.font = [UIFont systemFontOfSize:transactionMoney.frame.size.height/1.2];
    transactionMoney.textColor = [UIColor colorWithRed:0.26 green:0.71 blue:1 alpha:1];
    [firstDetails addSubview:transactionMoney];
    
    UILabel *transactionIntegral = [[UILabel alloc] initWithFrame:CGRectMake(transactionMoney.frame.size.width , 5, firstDetails.frame.size.width-transactionMoney.frame.size.width-10, firstDetails.frame.size.height/3)];
    transactionIntegral.text = @"积分:＋30";
    transactionIntegral.textColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1];
    transactionIntegral.font = [UIFont systemFontOfSize:transactionIntegral.frame.size.height/1.4];
    transactionIntegral.textAlignment = NSTextAlignmentRight;
    [firstDetails addSubview:transactionIntegral];
    
    UILabel *transactionDate = [[UILabel alloc] initWithFrame:CGRectMake(5, transactionMoney.frame.size.height*2, firstDetails.frame.size.width/2, firstDetails.frame.size.height/3)];
    transactionDate.text = @"2016-01-17 10:10";
    transactionDate.textColor = [UIColor blackColor];
    transactionDate.font = [UIFont systemFontOfSize:transactionDate.frame.size.height/1.5];
    [firstDetails addSubview:transactionDate];
    
    UILabel *transactionAddress = [[UILabel alloc] initWithFrame:CGRectMake(firstDetails.frame.size.width/2, transactionMoney.frame.size.height*2, firstDetails.frame.size.width/2, firstDetails.frame.size.height/3)];
    transactionAddress.text = @"充值地址:椒艳时光华瑞新天地步行街店";
    transactionAddress.textColor = [UIColor blackColor];
    transactionAddress.font = [UIFont systemFontOfSize:transactionAddress.frame.size.height/1.5];
    [firstDetails addSubview:transactionAddress];
    
    
    [transactionRecordsDetails addSubview:firstDetails];
    
    UIView *secondDetails = [[UIView alloc] initWithFrame:CGRectMake(0, firstDetails.frame.size.height+10, transactionRecordsDetails.frame.size.width, transactionRecordsDetails.frame.size.height/3.3)];
    secondDetails.layer.borderWidth = 1;
    secondDetails.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1].CGColor;
    
    UILabel *transactionMoney1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, firstDetails.frame.size.width/3, firstDetails.frame.size.height/3)];
    transactionMoney1.text = @"-300.00元";
    transactionMoney1.font = [UIFont systemFontOfSize:transactionMoney1.frame.size.height/1.2];
    transactionMoney1.textColor = [UIColor colorWithRed:0.97 green:0.56 blue:0.37 alpha:1];
    [secondDetails addSubview:transactionMoney1];
    
    UILabel *transactionIntegral1 = [[UILabel alloc] initWithFrame:CGRectMake(transactionMoney1.frame.size.width , 5, firstDetails.frame.size.width-transactionMoney1.frame.size.width-10, firstDetails.frame.size.height/3)];
    transactionIntegral1.text = @"积分:＋30";
    transactionIntegral1.textColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1];
    transactionIntegral1.font = [UIFont systemFontOfSize:transactionIntegral1.frame.size.height/1.4];
    transactionIntegral1.textAlignment = NSTextAlignmentRight;
    [secondDetails addSubview:transactionIntegral1];
    
    UILabel *transactionDate1 = [[UILabel alloc] initWithFrame:CGRectMake(5, transactionMoney1.frame.size.height*2, firstDetails.frame.size.width/2, firstDetails.frame.size.height/3)];
    transactionDate1.text = @"2016-01-17 10:10";
    transactionDate1.textColor = [UIColor blackColor];
    transactionDate1.font = [UIFont systemFontOfSize:transactionDate1.frame.size.height/1.5];
    [secondDetails addSubview:transactionDate1];
    
    UILabel *transactionAddress1 = [[UILabel alloc] initWithFrame:CGRectMake(firstDetails.frame.size.width/2, transactionMoney1.frame.size.height*2, firstDetails.frame.size.width/2, firstDetails.frame.size.height/3)];
    transactionAddress1.text = @"充值地址:椒艳时光华瑞新天地步行街店";
    transactionAddress1.textColor = [UIColor blackColor];
    transactionAddress1.font = [UIFont systemFontOfSize:transactionAddress1.frame.size.height/1.5];
    [secondDetails addSubview:transactionAddress1];
    
    [transactionRecordsDetails addSubview:secondDetails];
    
    
    UIView *thirdDetails = [[UIView alloc] initWithFrame:CGRectMake(0, firstDetails.frame.size.height+secondDetails.frame.size.height+20, transactionRecordsDetails.frame.size.width, transactionRecordsDetails.frame.size.height/3.3)];
    thirdDetails.layer.borderWidth = 1;
    thirdDetails.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1].CGColor;
    
    UILabel *transactionMoney2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, firstDetails.frame.size.width/3, firstDetails.frame.size.height/3)];
    transactionMoney2.text = @"-300分";
    transactionMoney2.font = [UIFont systemFontOfSize:transactionMoney2.frame.size.height/1.2];
    transactionMoney2.textColor = [UIColor colorWithRed:0.97 green:0.56 blue:0.37 alpha:1];
    [thirdDetails addSubview:transactionMoney2];
    
    UILabel *transactionIntegral2 = [[UILabel alloc] initWithFrame:CGRectMake(transactionMoney2.frame.size.width , 5, firstDetails.frame.size.width-transactionMoney2.frame.size.width-10, firstDetails.frame.size.height/3)];
    transactionIntegral2.text = @"积分:-300";
    transactionIntegral2.textColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1];
    transactionIntegral2.font = [UIFont systemFontOfSize:transactionIntegral2.frame.size.height/1.4];
    transactionIntegral2.textAlignment = NSTextAlignmentRight;
    [thirdDetails addSubview:transactionIntegral2];
    
    UILabel *transactionDate2 = [[UILabel alloc] initWithFrame:CGRectMake(5, transactionMoney2.frame.size.height*2, firstDetails.frame.size.width/2, firstDetails.frame.size.height/3)];
    transactionDate2.text = @"2016-01-17 10:10";
    transactionDate2.textColor = [UIColor blackColor];
    transactionDate2.font = [UIFont systemFontOfSize:transactionDate2.frame.size.height/1.5];
    [thirdDetails addSubview:transactionDate2];
    
    UILabel *transactionAddress2 = [[UILabel alloc] initWithFrame:CGRectMake(firstDetails.frame.size.width/2, transactionMoney2.frame.size.height*2, firstDetails.frame.size.width/2, firstDetails.frame.size.height/3)];
    transactionAddress2.text = @"充值地址:椒艳时光华瑞新天地步行街店";
    transactionAddress2.textColor = [UIColor blackColor];
    transactionAddress2.font = [UIFont systemFontOfSize:transactionAddress2.frame.size.height/1.5];
    [thirdDetails addSubview:transactionAddress2];

    
    [transactionRecordsDetails addSubview:thirdDetails];
    
    
    
    UIImageView *imageMap = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, SCREEN_HEIGHT/4)];
    imageMap.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/1.3);
    imageMap.image = [UIImage imageNamed:@"mapimage"];
    [self.view addSubview:imageMap];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //[self getUserDate];
    
}




@end
