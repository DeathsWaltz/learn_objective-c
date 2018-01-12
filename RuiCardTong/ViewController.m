//
//  ViewController.m
//  RuiCardTong
//
//  Created by waltz on 15/12/4.
//  Copyright  2015 ztej. All rights reserved.
//

#import "ViewController.h"
#import "GetUserDate.h"


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NextViewController *nextView;
    UICollectionView *contextCollectionview;
    CellContext * cell;
    UILabel *label;
    UIImageView *headrIcon;
    MoneyViewController *moneyView;
    TransferViewController *transferView;
    IntegralViewController *integralView;
    FinancialViewController *financinalView;
    TransactionRecordsViewController *transactionRecordsView;
    PersonageCenterViewController *personageCenterView;
    PersonageLoginViewController *personageLoginView;
    
    UILabel *firstlabel;
    // 第三方库，DSToast
    DSToast *toast;
    
    NSUserDefaults *info;
    NSDictionary *namePassword;
    
    NSDictionary *userInfo;
    
    NSDictionary *userData;
    
}

@end
//标示
static NSString *indentify = @"indentify";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //加载主布局
    [self mainView];
    
    [self AFNetworkAnalyzing];
}



#pragma mark - 主布局
//NavigationView
-(void)mainView
{
    // 实例化视图
    

    info = [NSUserDefaults standardUserDefaults];
    namePassword = [info objectForKey:@"info"];
    
    
    
    
    //bar标题设置
    [self barItemView];
    //头部视图
    [self headrView];
    //内容视图，collectionview
    [self addContextCollectionview];
    // 标题，lable
    [self labelView];
    //幻灯片，轮播图
    [self adPageView];
    
    
    
     
}
- (void)getUserDate
{
    
    if (namePassword == nil) {
        firstlabel.text = @"请登录";
    }else{
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:@"http://localhost:8081/ztcms/mobile/userLogin" parameters:namePassword success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
            
            if ([[responseObject objectForKey:@"code"] intValue] == 1) {
                userInfo = responseObject;
                userData = [userInfo objectForKey:@"data"];
                firstlabel.text = [userData objectForKey:@"membername"];
                NSLog(@"首页加载数据=========%@",responseObject);
            }
        
        
       
        
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
            NSLog(@"失败");
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器连接失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *errors = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:errors];
            [self presentViewController:alertController animated:YES completion:nil];
        
        }];
    }

}


#pragma mark -  bar标题设置
-(void)barItemView
{
    //设置baritem的图片
    UIImage *rightImage = [UIImage imageNamed:@"menu" ];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    //设置bar的背景为不透明，设置为蓝色，设置view的背景为白色
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.32 green:0.53 blue:1 alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    // 设置右侧返回字体颜色为白色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    // 设置标题颜色为白色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    

}
#pragma mark -  头部视图
-(void)headrView
{
    
    
    NSString *headUrl = [userInfo objectForKey:@"headUrl"];
  
    //设置头部视图，设置头部背景颜色为蓝色，把头部视图添加到主视图
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/5) ];

    //设置头部背景颜色
    headView.backgroundColor = [UIColor colorWithRed:0.32 green:0.53 blue:1 alpha:1];
    // 头像设置
    headrIcon = [[UIImageView alloc] init];
    headrIcon.frame = CGRectMake(SCREEN_WIDTH/6.8, headView.frame.size.height/7.6, SCREEN_WIDTH/6, SCREEN_WIDTH/6);
    headrIcon.backgroundColor = [UIColor whiteColor];
    //headrIcon.yy_imageURL = [NSURL URLWithString:@"http://img.zcool.cn/community/03320dd554c75c700000158fce17209.jpg"];
    
    headrIcon.layer.cornerRadius = headrIcon.frame.size.width/2;
    headrIcon.layer.masksToBounds = YES;
    //信息
    
    firstlabel = [[UILabel alloc] initWithFrame:CGRectMake(headrIcon.frame.size.width*2.5,headrIcon.frame.size.height/1.6 , SCREEN_WIDTH/5, 20)];
    firstlabel.font = [UIFont systemFontOfSize:18];
    firstlabel.numberOfLines = 1;
    firstlabel.adjustsFontSizeToFitWidth = YES;
    //firstlabel.layer.borderWidth = 1;
    //firstlabel.layer.borderColor = [UIColor blueColor].CGColor;
    
    
    
    
    

        headrIcon.image = [UIImage imageNamed:@"headImage"];

    
    firstlabel.textColor = [UIColor whiteColor];
    [headView addSubview:firstlabel];
    //将头像添加进头部视图
    [headView addSubview:headrIcon];
    //将头部视图添加到主视图
    [self.view addSubview:headView];
    [self addSingleTap];
}
#pragma mark - 设置头像点击
-(void)addSingleTap
{
    headrIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserImage)];
    [singleTap setNumberOfTouchesRequired:1];
    [singleTap setNumberOfTapsRequired:1];
    [headrIcon addGestureRecognizer:singleTap];
}
#pragma mark - 单击图片响应的方法
-(void)tapUserImage
{
    
    if ([[userInfo objectForKey:@"code"] intValue]== 1) {
       
        
        NSLog(@"userimage");
        personageCenterView.title = [NSString stringWithFormat:@"%@的个人中心",[userData objectForKey:@"membername"]];
        [self.navigationController pushViewController:personageCenterView animated:YES];

    }else{
        
        personageLoginView.title = @"登录";
        personageLoginView.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController pushViewController:personageLoginView animated:YES];

    }
    
}
#pragma mark - 创建collectionview视图
-(void)addContextCollectionview
{
    //创建一个块状表格布局对象
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    //格子的大小 (长，高)
    //创建collectionview视图
    
    contextCollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/5, SCREEN_WIDTH, SCREEN_HEIGHT/2.8) collectionViewLayout:flowLayout ];
    //contextCollectionview.layer.borderColor = [UIColor blackColor].CGColor;
    //contextCollectionview.layer.borderWidth = 1.0;
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3, contextCollectionview.frame.size.height/2);
    //横向最小距离
    flowLayout.minimumInteritemSpacing = 0.f;
    flowLayout.minimumLineSpacing = 0.f;
    //设置，上／左／下／右 边距 空间间隔数是多少
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //设置collectionview为可滑动
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //设置代理为控制器
    contextCollectionview.delegate = self;
    contextCollectionview.dataSource = self;
    //设置背景颜色
    contextCollectionview.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    //注册单元格
    [contextCollectionview registerClass:[CellContext class] forCellWithReuseIdentifier:indentify];
    //添加视图
    [self.view addSubview:contextCollectionview];
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
    cell = (CellContext *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1].CGColor;
    cell.layer.borderWidth = 1;
    //给单元格赋值
    NSArray *array = [NSArray arrayWithObjects:@"资金",@"转账",@"积分",@"理财",@"交易记录", nil];
    //cell.titleLab.text = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row];
    cell.titleLab.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:indexPath.row]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld",(long)indexPath.row]];
    
    cell.titleLab.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    
   /* switch (indexPath.row) {
        case 0:
            cell.layer.borderColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1].CGColor;
            cell.layer.borderWidth = 1;
            break;
        case 1:
            cell.layer.borderColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1].CGColor;
            cell.layer.borderWidth = 1;
            break;
        case 2:
            cell.layer.borderColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1].CGColor;
            cell.layer.borderWidth = 1;
            break;
        case 3:
            cell.layer.borderColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1].CGColor;
            cell.layer.borderWidth = 1;
            break;
        case 4:
            cell.layer.borderColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1].CGColor;
            cell.layer.borderWidth = 1;
            break;
    }*/
    
    return cell;
}
 //点击单元格事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
   
    
    switch (indexPath.row) {
        case 0:
            if ([[userInfo objectForKey:@"code"] intValue] == 1) {
            
                moneyView.title = @"资金";
                [self.navigationController pushViewController:moneyView animated:YES];
            }else{
                personageLoginView =[[PersonageLoginViewController alloc] init];
                personageLoginView.title = @"登录";
                [self.navigationController pushViewController:personageLoginView animated:YES];
             
            }
            break;
        case 1:
        {
            if ([[userInfo objectForKey:@"code"] intValue] == 1) {
                
                transferView.title = @"转账";
                [self.navigationController pushViewController:transferView animated:YES];
            }else{
                personageLoginView =[[PersonageLoginViewController alloc] init];
                 personageLoginView.title = @"登录";
                [self.navigationController pushViewController:personageLoginView animated:YES];
                
            }
            
            break;
        }
        case 2:
            
            
            
            if ([[userInfo objectForKey:@"code"] intValue] == 1) {
                
                integralView.title = @"积分";
                [self.navigationController pushViewController:integralView animated:YES];
            }else{
                personageLoginView =[[PersonageLoginViewController alloc] init];
                personageLoginView.title = @"登录";
                [self.navigationController pushViewController:personageLoginView animated:YES];
                
            }

            break;
        case 3:
        {
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"此功能暂未开放" preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancel];
            
            
               [self presentViewController:alertController animated:YES completion:nil];
            //UIAlertView *notOpened = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此功能暂未开放" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            //[notOpened show];
            financinalView.title = @"理财";
            //[self.navigationController pushViewController:financinalView animated:YES];
            break;
        }
        case 4:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"此功能暂未开放" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancel];
            
            
            [self presentViewController:alertController animated:YES completion:nil];
            transactionRecordsView.title = @"交易记录";
            //[self.navigationController pushViewController:transactionRecordsView animated:YES];
            break;
        }
    }
    
}


#pragma mark - 标题，lable
-(void)labelView
{
    label = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/5+contextCollectionview.frame.size.height+10, SCREEN_WIDTH, 15) ];
    //label.layer.borderWidth = 1;
    //label.layer.borderColor = [UIColor blackColor].CGColor;
    label.font = [UIFont systemFontOfSize:label.frame.size.height];
    label.text = @"为您推荐";
    [self.view addSubview:label];
}

   #pragma mark - 幻灯片，轮播图
    -(void)adPageView
    {
        NSArray *UrlStringArray = @[@"http://img2.imgtn.bdimg.com/it/u=3742507242,878331702&fm=27&gp=0.jpg",
                                    @"http://img2.niutuku.com/desk/1208/2150/ntk-2150-41037.jpg",
                                    @"http://img0.imgtn.bdimg.com/it/u=695059509,1186747419&fm=27&gp=0.jpg"];
        
       
        
        
        //显示顺序和数组顺序一致
        //设置图片url数组,和滚动视图位置
        
        DCPicScrollView  *picView =
        [[DCPicScrollView alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT/5+contextCollectionview.frame.size.height+10+15+10, SCREEN_WIDTH-20, SCREEN_HEIGHT/8.6) WithImageNames:UrlStringArray];
        
        
        //显示顺序和数组顺序一致
        //设置标题显示文本数组
        
        //picView.titleData = titleArray;
        
        //占位图片,你可以在下载图片失败处修改占位图片
        
        picView.placeImage = [UIImage imageNamed:@"imageloading"];
        
        //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
        
        [picView setImageViewDidTapAtIndex:^(NSInteger index) {
            printf("第%zd张图片\n",index);
            
            nextView.title = [NSString stringWithFormat:@"%ld",(long)index];
            nextView.url = [UrlStringArray objectAtIndex:index];
            [self.navigationController pushViewController:nextView animated:YES];
           
            
    }];
        
        //default is 2.0f,如果小于0.5不自动播放
        picView.AutoScrollDelay = 4.0f;
        
        [self.view addSubview:picView];
        
        //下载失败重复下载次数,默认不重复,
        [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
        
        //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
        //error错误信息
        //url下载失败的imageurl
        [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
            NSLog(@"%@",error);
        }];
    }

-(void)AFNetworkAnalyzing
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld",(long)status);
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"未联网");
                //[self alert:@"未联网"];
                toast = [[DSToast alloc] initWithText:@"无网络连接"];
                [toast show];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"使用wifi");
                //[self alert:@"使用wifi"];
                //toast = [[DSToast alloc] initWithText:@"正在使用WiFi上网"];
                [toast show];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"使用数据流量");
                //[self alert:@"使用数据流量"];
                //toast = [[DSToast alloc] initWithText:@"正在使用数据流量上网"];
                [toast show];
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                //[self alert:@"未知"];
                toast = [[DSToast alloc] initWithText:@"未知网络"];
                [toast show];
                break;
        }
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getUserDate];
    
    //GetUserDate *getDate = [[GetUserDate alloc] init];
    //NSLog(@"-=-=-=-=-=-=-=-=-%@",[getDate getUserDate:namePassword] );
    
    
    
    nextView = [[NextViewController alloc] init];
    personageCenterView = [[PersonageCenterViewController alloc]init];
    personageLoginView = [[PersonageLoginViewController alloc] init];
    moneyView = [[MoneyViewController alloc] init];
    //transferTableView = [[TransferTableViewTableViewController alloc] init];
    transferView = [[TransferViewController alloc] init];
    integralView = [[IntegralViewController alloc] init];
    financinalView = [[FinancialViewController alloc] init];
    transactionRecordsView = [[TransactionRecordsViewController alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
