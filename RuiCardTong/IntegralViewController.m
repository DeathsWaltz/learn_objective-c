//
//  IntegralViewController.m
//  RuiCardTong
//
//  Created by waltz on 15/12/15.
//  Copyright (c) 2015 ztej. All rights reserved.
//

#import "IntegralViewController.h"

@interface IntegralViewController ()
{
    UIView *integralTopView;
    UIView *integralFunctionView;
    
    UILabel *usableIntegralContext;
    
    NSUserDefaults *info;
    
    
    NSDictionary *namePassword;
    
    NSDictionary *userInfo;
    
    NSDictionary *userData;

}

@end

@implementation IntegralViewController




- (void)viewDidLoad
{
    info = [NSUserDefaults standardUserDefaults];
    namePassword = [info objectForKey:@"info"];
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    // 加载主视图
    [self mainView];
    
}

#pragma mark - 主视图
- (void)mainView
{
    
    
    
    // 加载顶部视图
    [self addInegralTopView];
    // 加载积分功能视图
    [self addIntegralFunctionView];
    // 加载猜您喜欢视图
    [self addGuessYouLikeView];
}

#pragma mark - 顶部视图
- (void)addInegralTopView
{
    
    integralTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2.5)];
    integralTopView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self.view addSubview:integralTopView];
    
    
    UILabel *usableIntegralTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10,integralTopView.frame.size.width , integralTopView.frame.size.height/14)];
    usableIntegralTitle.textColor = [UIColor blackColor];
    usableIntegralTitle.textAlignment = NSTextAlignmentCenter;
    usableIntegralTitle.font = [UIFont systemFontOfSize:usableIntegralTitle.frame.size.height-5];
    usableIntegralTitle.text = @"可用积分";
    [integralTopView addSubview:usableIntegralTitle];
    
    
    usableIntegralContext = [[UILabel alloc] initWithFrame:CGRectMake(0, 20+usableIntegralTitle.frame.size.height, integralTopView.frame.size.width, integralTopView.frame.size.height/5)];
    usableIntegralContext.text = [NSString stringWithFormat:@"暂无数据"];
    usableIntegralContext.textColor = [UIColor colorWithRed:0.3 green:0.73 blue:1 alpha:1];
    usableIntegralContext.font = [UIFont systemFontOfSize:usableIntegralContext.frame.size.height];
    usableIntegralContext.textAlignment = NSTextAlignmentCenter;
    [integralTopView addSubview:usableIntegralContext];
    
    
    UIImageView *usableIntegralImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30+usableIntegralContext.frame.size.height+usableIntegralTitle.frame.size.height, integralTopView.frame.size.width, integralTopView.frame.size.height/9)];
    usableIntegralImage.image = [UIImage imageNamed:@"usableIntegralImage"];
    usableIntegralImage.contentMode = UIViewContentModeScaleAspectFit;
    [integralTopView addSubview:usableIntegralImage];
    
    
    UILabel *usageRuleTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 30+usableIntegralContext.frame.size.height+usableIntegralTitle.frame.size.height+usableIntegralImage.frame.size.height, integralTopView.frame.size.width, integralTopView.frame.size.height/19)];
    usageRuleTitle.text = @"使用规则";
    usageRuleTitle.textColor = [UIColor grayColor];
    usageRuleTitle.font = [UIFont systemFontOfSize:usageRuleTitle.frame.size.height];
    NSLog(@"%f",usageRuleTitle.frame.size.height);
    [integralTopView addSubview:usageRuleTitle];
    
    
    UILabel *usageRuleContext = [[UILabel alloc] initWithFrame:CGRectMake(30, usageRuleTitle.frame.size.height+usableIntegralContext.frame.size.height+usableIntegralImage.frame.size.height+usableIntegralTitle.frame.size.height+40, integralTopView.frame.size.width-60, integralTopView.frame.size.height-usableIntegralImage.frame.size.height-usableIntegralContext.frame.size.height-usableIntegralTitle.frame.size.height-55)];
    usageRuleContext.text = @"1.此积分只能在瑞卡社区内使用，可用于购物和礼品兑换\n2.积分可抵现金，但不可提现，不可兑现，每一百积分为一元";
    usageRuleContext.numberOfLines = 4;
    usageRuleContext.font = [UIFont systemFontOfSize:usageRuleContext.frame.size.height/9];
    usageRuleContext.textColor = [UIColor grayColor];
    NSLog(@"%f",usageRuleContext.frame.size.height/9);
    [integralTopView addSubview:usageRuleContext];
}

#pragma mark - 积分功能视图
- (void)addIntegralFunctionView
{
    integralFunctionView = [[UIView alloc] initWithFrame:CGRectMake(0, integralTopView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT/8)];
    integralFunctionView.layer.borderWidth = 1;
    integralFunctionView.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1].CGColor;
    [self.view addSubview:integralFunctionView];
    
    // 积分排名选项
    UIView *integralOrderbyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, integralFunctionView.frame.size.width/3, integralFunctionView.frame.size.height)];
    integralOrderbyView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    UILabel *integralOrderbyTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, integralOrderbyView.frame.size.width, integralOrderbyView.frame.size.height/6)];
    integralOrderbyTitle.center = CGPointMake(integralOrderbyTitle.frame.size.width/2, integralOrderbyView.frame.size.height/1.2);
    integralOrderbyTitle.text = @"积分排名";
    integralOrderbyTitle.font = [UIFont systemFontOfSize:integralOrderbyTitle.frame.size.height];
    integralOrderbyTitle.textAlignment = NSTextAlignmentCenter;
    integralOrderbyTitle.textColor = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1];
    [integralOrderbyView addSubview:integralOrderbyTitle];
    [integralFunctionView addSubview:integralOrderbyView];
    // 积分兑换选项
    UIView *integralExchangeView = [[UIView alloc] initWithFrame:CGRectMake(integralOrderbyView.frame.size.width, 0, integralFunctionView.frame.size.width/3, integralFunctionView.frame.size.height)];
    integralExchangeView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    integralExchangeView.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1].CGColor;
    integralExchangeView.layer.borderWidth = 1;
    UILabel *integralExchangeTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, integralOrderbyView.frame.size.width, integralOrderbyView.frame.size.height/6)];
    integralExchangeTitle.center = CGPointMake(integralOrderbyTitle.frame.size.width/2, integralOrderbyView.frame.size.height/1.2);
    integralExchangeTitle.text = @"积分兑换";
    integralExchangeTitle.font = [UIFont systemFontOfSize:integralOrderbyTitle.frame.size.height];
    integralExchangeTitle.textAlignment = NSTextAlignmentCenter;
    integralExchangeTitle.textColor = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1];
    [integralExchangeView addSubview:integralExchangeTitle];
    [integralFunctionView addSubview:integralExchangeView];
    // 积分抽奖选项
    UIView *integralDrawView = [[UIView alloc] initWithFrame:CGRectMake(integralOrderbyView.frame.size.width+integralExchangeView.frame.size.width, 0, integralFunctionView.frame.size.width/3, integralFunctionView.frame.size.height)];
    integralDrawView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    UILabel *integralDrawTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, integralOrderbyView.frame.size.width, integralOrderbyView.frame.size.height/6)];
    integralDrawTitle.center = CGPointMake(integralOrderbyTitle.frame.size.width/2, integralOrderbyView.frame.size.height/1.2);
    integralDrawTitle.text = @"积分抽奖";
    integralDrawTitle.font = [UIFont systemFontOfSize:integralOrderbyTitle.frame.size.height];
    integralDrawTitle.textAlignment = NSTextAlignmentCenter;
    integralDrawTitle.textColor = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1];
    [integralDrawView addSubview:integralDrawTitle];
    [integralFunctionView addSubview:integralDrawView];
    
}

#pragma mark - 猜您喜欢视图
- (void)addGuessYouLikeView
{
    UIView *guessYouLikeView = [[UIView alloc] initWithFrame:CGRectMake(0, integralTopView.frame.size.height+integralFunctionView.frame.size.height+5, SCREEN_WIDTH, SCREEN_HEIGHT-(integralTopView.frame.size.height+integralFunctionView.frame.size.height+20))];
    guessYouLikeView.backgroundColor = [UIColor clearColor];
    
    UILabel *guessYouLikeTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, guessYouLikeView.frame.size.width/6, (guessYouLikeView.frame.size.height-5)/22)];
    guessYouLikeTitle.text = @"猜您喜欢";
    guessYouLikeTitle.font = [UIFont systemFontOfSize:guessYouLikeTitle.frame.size.height];
    guessYouLikeTitle.textAlignment = NSTextAlignmentCenter;
    guessYouLikeTitle.textColor = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1];
    [guessYouLikeView addSubview:guessYouLikeTitle];
    
    UIImageView *guessYouLikeContext = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, guessYouLikeView.frame.size.width-40, guessYouLikeView.frame.size.height/2.5)];
    guessYouLikeContext.center = CGPointMake(guessYouLikeView.frame.size.width/2, guessYouLikeContext.frame.size.height/2+(guessYouLikeTitle.frame.size.height+25));
    guessYouLikeContext.yy_imageURL = [NSURL URLWithString:@"http://pic33.nipic.com/20130910/11567910_161318233189_2.jpg"];

    guessYouLikeContext.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    [singleTap setNumberOfTouchesRequired:1];
    [singleTap setNumberOfTapsRequired:1];
    [guessYouLikeContext addGestureRecognizer:singleTap];
    
    [guessYouLikeView addSubview:guessYouLikeContext];
    
    
    
    UIButton *getIntegral = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, guessYouLikeView.frame.size.width/3.5, guessYouLikeView.frame.size.height/8)];
    getIntegral.center = CGPointMake(guessYouLikeView.frame.size.width/2, guessYouLikeView.frame.size.height/1.5);
    getIntegral.backgroundColor = [UIColor colorWithRed:0.3 green:0.61 blue:1 alpha:1];
    [getIntegral setTitle:@"赚积分" forState:UIControlStateNormal];
    getIntegral.titleLabel.font = [UIFont systemFontOfSize:getIntegral.frame.size.height/2.5];
    getIntegral.tintColor = [UIColor whiteColor];
    getIntegral.layer.cornerRadius = getIntegral.frame.size.height/2;
    [getIntegral addTarget:self action:@selector(tapImage) forControlEvents:UIControlEventTouchUpInside];
    [guessYouLikeView addSubview:getIntegral];
    
    [self.view addSubview:guessYouLikeView];
    
}

#pragma mark - 图片点击
-(void)tapImage
{
    
    NextViewController *web = [[NextViewController alloc] init];
    [self.navigationController pushViewController:web animated:YES];
}
- (void)getUserDate
{
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://localhost:8081/ztcms/mobile/userLogin" parameters:namePassword success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue] == 1) {
            userInfo = responseObject;
            userData = [userInfo objectForKey:@"data"];
            usableIntegralContext.text = [NSString stringWithFormat:@"%ld",[[userData objectForKey:@"pointblance"] integerValue]];
            
            
            
            NSLog(@"=%@",responseObject);
        }else{
            
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"失败=[======");
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getUserDate];
    
    //usableIntegralContext.text = [NSString stringWithFormat:@"%ld",[[userData objectForKey:@"pointblance"] integerValue]];
    NSLog(@"%ld",[[userData objectForKey:@"pointblance"] integerValue]);
    
}

@end
