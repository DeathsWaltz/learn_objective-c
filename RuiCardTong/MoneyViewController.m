//
//  MoneyViewController.m
//  RuiCardTong
//
//  Created by waltz on 15/12/15.
//  Copyright (c) 2015 ztej. All rights reserved.
//

#import "MoneyViewController.h"

@interface MoneyViewController()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *moneyViewCollection;
    AccountBalanceViewController *accountBalance;
    MoneyContextCell *cell;
    
    UILabel *totalAssetsContext;
    UILabel *balanceContext;
    
    NSUserDefaults *info;
    
    
    NSDictionary *namePassword;
    
    NSDictionary *userInfo;
    
    NSDictionary *userData;
    
    
    NSArray *context;
    
}
@end
static NSString *indentify = @"indentifys";
@implementation MoneyViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    // 主视图
    
    [self mainView];
    

    
   
}
- (void)mainView
{
    
    info = [NSUserDefaults standardUserDefaults];
    namePassword = [info objectForKey:@"info"];
    // 添加头部视图
    [self addHeadView];
    // 添加CollectionView视图
    [self addContextCollectionview];
}
- (void)getUserDate
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://localhost:8081/ztcms/mobile/userLogin" parameters:namePassword success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue] == 1) {
            userInfo = responseObject;
            userData = [userInfo objectForKey:@"data"];
            totalAssetsContext.text = [NSString stringWithFormat:@"%@ 元",[userData objectForKey:@"balance"]];
            balanceContext.text = [NSString stringWithFormat:@"%@ 元",[userData objectForKey:@"balance"]];
            
            
            
            NSLog(@"=%@",responseObject);
        }else{
            
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"失败");
    }];
    
}

#pragma mark - 创建头部视图
-(void)addHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3-20)];
    headView.backgroundColor = [UIColor colorWithRed:0.32 green:0.53 blue:1 alpha:1];
    [self.view addSubview:headView];
    
    UILabel *totalAssetsTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headView.frame.size.height/10)];
    totalAssetsTitle.font = [UIFont systemFontOfSize:15];
    totalAssetsTitle.center = CGPointMake(SCREEN_WIDTH/2, STATUS_BAR_HEIGHT);
    totalAssetsTitle.textAlignment = NSTextAlignmentCenter;
    totalAssetsTitle.text = @"可用资产";
    totalAssetsTitle.textColor = [UIColor whiteColor];
    [headView addSubview:totalAssetsTitle];
    
    totalAssetsContext = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, headView.frame.size.height/6)];
    totalAssetsContext.text = [NSString stringWithFormat:@"%.2f",123123.11];
    totalAssetsContext.font = [UIFont systemFontOfSize:17];
    totalAssetsContext.center = CGPointMake(SCREEN_WIDTH/2, totalAssetsTitle.frame.size.height+STATUS_BAR_HEIGHT+5);
    totalAssetsContext.textAlignment = NSTextAlignmentCenter;
    totalAssetsContext.textColor = [UIColor whiteColor];
    [headView addSubview:totalAssetsContext];
    
    UILabel *balanceTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headView.frame.size.height/15)];
    balanceTitle.center = CGPointMake(SCREEN_WIDTH/2,totalAssetsTitle.frame.size.height+STATUS_BAR_HEIGHT+totalAssetsContext.frame.size.height+10);
    balanceTitle.font = [UIFont systemFontOfSize:12];
    balanceTitle.textAlignment = NSTextAlignmentCenter;
    balanceTitle.text = @"总资产";
    balanceTitle.textColor = [UIColor whiteColor];
    [headView addSubview:balanceTitle];
    
    balanceContext = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headView.frame.size.height/16)];
    balanceContext.textAlignment = NSTextAlignmentCenter;
    balanceContext.center = CGPointMake(SCREEN_WIDTH/2, totalAssetsTitle.frame.size.height+STATUS_BAR_HEIGHT+totalAssetsContext.frame.size.height+balanceTitle.frame.size.height+12);
    balanceContext.text = [NSString stringWithFormat:@"%.2f 元",123123.11];
    balanceContext.font = [UIFont systemFontOfSize:12];
    balanceContext.textColor = [UIColor whiteColor];
    [headView addSubview:balanceContext];
    
    UIImageView *balanceImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/30, headView.frame.size.height/20) ];
    balanceImage.center = CGPointMake(SCREEN_WIDTH/2,  totalAssetsTitle.frame.size.height+STATUS_BAR_HEIGHT+totalAssetsContext.frame.size.height+balanceTitle.frame.size.height+balanceContext.frame.size.height+15);
    balanceImage.contentMode = UIViewContentModeScaleAspectFill;
    balanceImage.image = [UIImage imageNamed:@"balance"];
    [headView addSubview:balanceImage];
    
}

#pragma mark - 创建collectionview视图
-(void)addContextCollectionview
{
    //创建一个块状表格布局对象
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    //格子的大小 (长，高)
    //创建collectionview视图
    moneyViewCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/5, SCREEN_WIDTH, SCREEN_HEIGHT/2) collectionViewLayout:flowLayout ];
    //contextCollectionview.layer.borderColor = [UIColor blackColor].CGColor;
    //contextCollectionview.layer.borderWidth = 1.0;
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/2, moneyViewCollection.frame.size.height/3);
    //横向最小距离
    flowLayout.minimumInteritemSpacing = 0.f;
    flowLayout.minimumLineSpacing = 0.f;
    //设置，上／左／下／右 边距 空间间隔数是多少
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //设置collectionview为可滑动
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //设置代理为控制器
    moneyViewCollection.delegate = self;
    moneyViewCollection.dataSource = self;
    //设置背景颜色
    moneyViewCollection.backgroundColor = [UIColor whiteColor];
    //注册单元格
    [moneyViewCollection registerClass:[MoneyContextCell class] forCellWithReuseIdentifier:indentify];
    //添加视图
    [self.view addSubview:moneyViewCollection];
}


#pragma mark - UICollectionView dataSource
//设置Section个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//设置每个Section中有几个元素
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
//每个单元格的数据
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化单元格
    cell = (MoneyContextCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1].CGColor;
    cell.layer.borderWidth = 1.0;
    //给单元格赋值
    NSArray *title = [NSArray arrayWithObjects:@"余额",@"银行卡",@"理财",@"网购",@"多客服", nil];
    context = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@ 元",[userData objectForKey:@"balance"]],@"0",@"投资众投，值得拥有",@"网购，多元选择",@"智能回答，人工客服", nil];
    //cell.titleLab.text = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row];
    cell.moneyViewImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"moneyimage%ld",(long)indexPath.row]];
    cell.moneyViewtitle.text = [NSString stringWithFormat:@"%@",[title objectAtIndex:indexPath.row]];
    cell.moneyViewtitle.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    cell.moneyViewContext.text = [NSString stringWithFormat:@"%@",[context objectAtIndex:indexPath.row]];
    cell.moneyViewContext.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    
    
    //cellhight = cell.frame.size.height;
    NSLog(@"%f",cell.frame.size.height);
    return cell;
}
//点击单元格事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    
    switch (indexPath.row) {
        case 0:
            accountBalance.title = @"账户余额";
            [self.navigationController pushViewController:accountBalance animated:YES];
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
           
            break;
        case 4:
           
            break;
    }
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self getUserDate];
    accountBalance = [[AccountBalanceViewController alloc] init];

}



@end
