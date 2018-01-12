//
//  TransferViewController.m
//  RuiCardTong
//
//  Created by waltz on 15/12/15.
//  Copyright (c) 2015 ztej. All rights reserved.
//

#import "TransferViewController.h"

@interface TransferViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *contextTableView;
    TransferCell *cell;
    // 开户行信息视图
    BankNameTableViewController *bankNameTableView;
    
    // 开户行内容信息
    UIView *bankNameCellContext;
   
    
    //用户数据
    NSUserDefaults *userInfo;
    NSDictionary *userMoreInfo;
    NSDictionary *userData;
    
    //付款人
    UILabel *draweeName;
    
    //收款账户
    UITextField *accountNameContext;
    //开户行
    UILabel *bankNameContext;
    //转账金额
    UITextField *transferAmountContext;
    //短信提醒
    UISwitch *SMSReminderContext;
    //短信提醒手机号码
    UITextField *SMSReminderNumberContext;
}
@end
// tableview的标示
static NSString *headIdentifier = @"header";
static NSString *cellIdentifier = @"Cell";

@implementation TransferViewController
-(void)viewDidLoad
{
    // 设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 主视图
    [self mainView];
}
- (void)mainView
{
    
    userInfo = [NSUserDefaults standardUserDefaults];
    userMoreInfo  =[userInfo objectForKey:@"userMoreInfo"];
    userData = [userMoreInfo objectForKey:@"data"];
    
    // 加载TableView
    [self addTabelView];
}

#pragma mark - TabelViwe视图
- (void)addTabelView
{
    contextTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, SCREEN_HEIGHT-20) style:UITableViewStylePlain];
    bankNameCellContext = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.contextView.frame.size.width, cell.contextView.frame.size.height)];

    contextTableView.delegate = self;
    contextTableView.dataSource = self;
    //contextTableView.opaque = NO;
    //contextTableView.backgroundColor = [UIColor clearColor];
    //contextTableView.backgroundView = nil;
    //contextTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contextTableView.bounces = NO;
    [contextTableView registerClass:[TransferCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:contextTableView];
    
    

}


#pragma mark - UITableView Datasource

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
    return 5;
}

#pragma mark -  设置Tableview的表头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return SCREEN_HEIGHT/4.2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *userInfoView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, SCREEN_HEIGHT/4.2)];
    userInfoView.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1].CGColor;
    userInfoView.layer.borderWidth = 1;
    
    
    UIImageView * headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/5,SCREEN_WIDTH/5)];
    headIcon.image = [UIImage imageNamed:@"headImage"];
    headIcon.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1].CGColor;
    headIcon.layer.borderWidth = 1.0f;
    headIcon.layer.masksToBounds = YES;
    headIcon.layer.cornerRadius = headIcon.frame.size.width/2;
    headIcon.center = CGPointMake(userInfoView.frame.size.width/2, NAVIGATION_BAR_HEIGHT+5);
    [userInfoView addSubview:headIcon];
    
    UILabel *beneficiary = [[UILabel alloc] initWithFrame:CGRectMake(userInfoView.frame.size.width/2-userInfoView.frame.size.width/7, headIcon.frame.size.height+20, userInfoView.frame.size.width/7, userInfoView.frame.size.height/13)];
    beneficiary.text = @"收款人：";
    beneficiary.textColor = [UIColor blackColor];
    beneficiary.font = [UIFont systemFontOfSize:beneficiary.frame.size.height];
    [userInfoView addSubview:beneficiary];
    
    UILabel *beneficiaryName = [[UILabel alloc] initWithFrame:CGRectMake(beneficiary.frame.origin.x+beneficiary.frame.size.width,headIcon.frame.size.height+20, userInfoView.frame.size.width/4, userInfoView.frame.size.height/13)];
    beneficiaryName.text = [NSString stringWithFormat:@"BeneficiaryName"];
    beneficiaryName.textColor = [UIColor colorWithRed:0.38 green:0.51 blue:1 alpha:1];
    beneficiaryName.font = [UIFont systemFontOfSize:beneficiaryName.frame.size.height];
    [userInfoView addSubview:beneficiaryName];
    
    UILabel *drawee = [[UILabel alloc] initWithFrame:CGRectMake(10, userInfoView.frame.size.height/1.2, userInfoView.frame.size.width/7+10, userInfoView.frame.size.height/13)];
    drawee.text =  @"付款人：";
    drawee.font = [UIFont systemFontOfSize:drawee.frame.size.height];
    drawee.textColor = [UIColor blackColor];
    [userInfoView addSubview:drawee];
    
    draweeName = [[UILabel alloc] initWithFrame:CGRectMake(drawee.frame.size.width, userInfoView.frame.size.height/1.2, userInfoView.frame.size.width/4, userInfoView.frame.size.height/13)];
    //draweeName.text = [NSString stringWithFormat:@"DraweeName"];
    
    draweeName.text = [NSString stringWithFormat:[userData objectForKey:@"membername"]];
    
    draweeName.font = [UIFont systemFontOfSize:draweeName.frame.size.height];
    draweeName.textColor = [UIColor blackColor];
    draweeName.textColor = [UIColor colorWithRed:0.38 green:0.51 blue:1 alpha:1];
    [userInfoView addSubview:draweeName];

    
    return userInfoView;
}
#pragma mark -  设置Tableview的表尾
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return SCREEN_HEIGHT/5;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *buttonGroup = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/5)];
    buttonGroup.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1].CGColor;
    buttonGroup.layer.borderWidth = 1;
    
    UIButton *confirmTheTransfer = [[UIButton alloc] initWithFrame:CGRectMake(10, buttonGroup.frame.size.height/4, buttonGroup.frame.size.width-40, buttonGroup.frame.size.height/4)];
    [confirmTheTransfer setTitle:@"确认转账" forState:UIControlStateNormal];
    confirmTheTransfer.backgroundColor = [UIColor colorWithRed:0.38 green:0.51 blue:1 alpha:1];
    confirmTheTransfer.tintColor = [UIColor whiteColor];
    confirmTheTransfer.layer.cornerRadius = 10;
    confirmTheTransfer.titleLabel.font = [UIFont systemFontOfSize:15];
    [confirmTheTransfer addTarget:self action:@selector(confirmTheTransfer) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:confirmTheTransfer];
    
    UIButton *cancelTheTransfer = [[UIButton alloc] initWithFrame:CGRectMake(10, confirmTheTransfer.frame.size.height+10+buttonGroup.frame.size.height/4, buttonGroup.frame.size.width-40, buttonGroup.frame.size.height/4)];
    [cancelTheTransfer setTitle:@"取消转账" forState:UIControlStateNormal];
    cancelTheTransfer.backgroundColor = [UIColor orangeColor];
    cancelTheTransfer.tintColor = [UIColor whiteColor];
    cancelTheTransfer.titleLabel.font = [UIFont systemFontOfSize:15];
    cancelTheTransfer.layer.cornerRadius = 10;
    [buttonGroup addSubview:cancelTheTransfer];
    
    
    return buttonGroup;
}

- (void)confirmTheTransfer
{
    
    
    NSString *accuntNameContextString = accountNameContext.text;
    NSString *bankNameContextString = bankNameContext.text;
    NSString *transferAmountContextString = transferAmountContext.text;
    BOOL SMSReminderContextBool = SMSReminderContext.on;
    NSString *SMSReminderNumberContextString = SMSReminderNumberContext.text;
    NSString *draweeNameContext = draweeName.text;
    if (SMSReminderContextBool) {
        NSLog(@"YES");
    }else{
        NSLog(@"NO");
    }
    
    NSLog(@"accuntName: %@, bankName: %@, transferAmount: %@,  SMSReminderNumber: %@, draweeNameContext:%@",accuntNameContextString,bankNameContextString,transferAmountContextString,SMSReminderNumberContextString,draweeNameContext);
}



#pragma mark - 设置TableView的响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (indexPath.row == 1) {
        NSLog(@"=============");
        bankNameTableView = [[BankNameTableViewController alloc] init];
        
         //[[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.navigationController pushViewController:bankNameTableView animated:YES];
        
        
        }

}



#pragma mark - 设置TableView的内容

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell) {
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        cell = [[TransferCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.row) {
            case 0:
            {
                
                
                UILabel *accountNameTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.contextView.frame.size.height/6, cell.contextView.frame.size.width/5, cell.contextView.frame.size.height/1.5)];
                accountNameTitle.text = @"收款账户:";
                //accountNameTitle.center = CGPointMake(cell.frame.size.width/8, cell.frame.size.height/1.6);
                accountNameTitle.textColor = [UIColor blackColor];
                //[accountNameTitle sizeToFit];
                accountNameTitle.font = [UIFont systemFontOfSize:13];
                [cell.contextView addSubview:accountNameTitle];
                
                accountNameContext = [[UITextField alloc]initWithFrame:CGRectMake(accountNameTitle.frame.size.width+10, cell.contextView.frame.size.height/6, cell.contextView.frame.size.width/1.5,cell.contextView.frame.size.height/1.5 ) ];
                accountNameContext.font = [UIFont systemFontOfSize:15];
                accountNameContext.layer.borderColor = [UIColor grayColor].CGColor;
                accountNameContext.layer.borderWidth = 1;
                accountNameContext.layer.cornerRadius = 5;
                [cell.contextView addSubview:accountNameContext];
                
            }
                break;
                
            case 1:
            {
                
                
                //bankNameCellContext.backgroundColor = [UIColor blackColor];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                UILabel *bankNameTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.contextView.frame.size.height/6, cell.frame.size.width/6, cell.contextView.frame.size.height/1.5)];
                bankNameTitle.text = @"开户行:";
                //[bankNameTitle sizeToFit] ;
                bankNameTitle.textColor = [UIColor blackColor];
                bankNameTitle.font = [UIFont systemFontOfSize:13];
                [bankNameCellContext addSubview:bankNameTitle];
                
                
                //bankNameContext.layer.borderColor = [UIColor blackColor].CGColor;
                //bankNameContext.layer.borderWidth = 1;
                bankNameContext =  [[UILabel alloc] initWithFrame:CGRectMake(bankNameTitle.frame.size.width, cell.contextView.frame.size.height/6, cell.contextView.frame.size.width/1.5,cell.contextView.frame.size.height/1.5 )];
                bankNameContext.textAlignment = NSTextAlignmentCenter;
                
                bankNameContext.textColor = [UIColor colorWithRed:0.38 green:0.51 blue:1 alpha:1];
                bankNameContext.font = [UIFont systemFontOfSize:13];
                [bankNameCellContext addSubview:bankNameContext];
                [cell.contextView addSubview:bankNameCellContext];
                
            }
                
                
                break;
            case 2:
            {
                
                UILabel *transferAmountTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.contextView.frame.size.height/6, cell.contextView.frame.size.width/5, cell.contextView.frame.size.height/1.5)];
                transferAmountTitle.text = @"转账金额:";
                //[transferAmountTitle sizeToFit];
                transferAmountTitle.textColor = [UIColor blackColor];
                transferAmountTitle.font = [UIFont systemFontOfSize:13];
                [cell.contextView addSubview:transferAmountTitle];
                
                transferAmountContext = [[UITextField alloc]initWithFrame:CGRectMake(transferAmountTitle.frame.size.width+10, cell.contextView.frame.size.height/6, cell.contextView.frame.size.width/1.5,cell.contextView.frame.size.height/1.5 ) ];
                transferAmountContext.font = [UIFont systemFontOfSize:15];
                transferAmountContext.layer.borderColor = [UIColor grayColor].CGColor;
                transferAmountContext.layer.borderWidth = 1;
                transferAmountContext.layer.cornerRadius = 5;
                [cell.contextView addSubview:transferAmountContext];
                
            }
                
                break;
            case 3:
            {
                
                UILabel *SMSReminderTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.contextView.frame.size.height/6, cell.contextView.frame.size.width/5, cell.contextView.frame.size.height/1.5)];
                SMSReminderTitle.text = @"短信提醒:";
                //[SMSReminderTitle sizeToFit];
                SMSReminderTitle.textColor = [UIColor blackColor];
                SMSReminderTitle.font = [UIFont systemFontOfSize:13];
                [cell.contextView addSubview:SMSReminderTitle];
                
                
                SMSReminderContext = [[UISwitch alloc] initWithFrame:CGRectZero];
                SMSReminderContext.center = CGPointMake(cell.contextView.frame.size.width-SMSReminderTitle.frame.size.width, cell.contextView.frame.size.height/2);
                SMSReminderContext.onTintColor = [UIColor colorWithRed:0.38 green:0.51 blue:1 alpha:1];
                [SMSReminderContext setOn:YES];
                [cell.contextView addSubview:SMSReminderContext];
                
            }
                
                
                break;
            case 4:
            {
                
                UILabel *SMSReminderNumberTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.contextView.frame.size.height/6, cell.contextView.frame.size.width/2.6, cell.contextView.frame.size.height/1.5)];
                SMSReminderNumberTitle.text = @"短信提醒手机号码:";
                //[SMSReminderNumberTitle sizeToFit];
                SMSReminderNumberTitle.textColor = [UIColor blackColor];
                SMSReminderNumberTitle.font = [UIFont systemFontOfSize:13];
                [cell.contextView addSubview:SMSReminderNumberTitle];
                
                SMSReminderNumberContext = [[UITextField alloc]initWithFrame:CGRectMake(SMSReminderNumberTitle.frame.size.width+10, cell.contextView.frame.size.height/6, cell.contextView.frame.size.width/2.1,cell.contextView.frame.size.height/1.5) ];
                SMSReminderNumberContext.placeholder = @"(选填)";
                SMSReminderNumberContext.font = [UIFont systemFontOfSize:15];
                SMSReminderNumberContext.layer.borderColor = [UIColor grayColor].CGColor;
                SMSReminderNumberContext.layer.borderWidth = 1;
                SMSReminderNumberContext.layer.cornerRadius = 5;
                [cell.contextView addSubview:SMSReminderNumberContext];
                
            }
                
                break;
        }    
    
    return cell;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"1");
   
    
    NSLog(@"bankname%@",bankNameTableView.bankName);
    if ( bankNameTableView.bankName.length != 0) {
        // 有数据
        bankNameContext.text =  [NSString stringWithFormat:@"%@", bankNameTableView.bankName ];
    }

}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 1;
}


@end
