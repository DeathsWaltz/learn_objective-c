//
//  PersonageLoginViewController.m
//  RuiCardTong
//
//  Created by waltz on 15/12/16.
//  Copyright (c) 2015 ztej. All rights reserved.
//

#import "PersonageLoginViewController.h"
#import "GetUserDate.h"

@interface PersonageLoginViewController ()
{
    UITextField *userName;
    UITextField *password;
    ViewController *viewController;
    UIImageView *headIcon;
    UIView *userInfoUI;
    UIButton *login;
    
    DSToast *nullToast;
    
    DSToast *wrongToast;
}

@end



@implementation PersonageLoginViewController
-(void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    viewController = [[ViewController alloc] init];
    // 设置头像视图
    [self addHeadIcon];
    // 设置输入框视图
    [self addUserDate];
    // 设置底部视图
    [self addBottom];
    

}


#pragma mark - 头像
-(void)addHeadIcon
{
    
    headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/5,SCREEN_WIDTH/5)];
    headIcon.image = [UIImage imageNamed:@"headImage"];
    headIcon.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1].CGColor;
    headIcon.layer.borderWidth = 1.0f;
    headIcon.layer.masksToBounds = YES;
    headIcon.layer.cornerRadius = headIcon.frame.size.width/2;
    headIcon.center = CGPointMake(SCREEN_WIDTH/2, STATUS_AND_NAVIGATION_HEIGHT);
    [self.view addSubview:headIcon];
}
#pragma mark - 用户输入框信息
-(void)addUserDate
{
   
    userInfoUI = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, SCREEN_HEIGHT/7)];
    userInfoUI.backgroundColor = [UIColor whiteColor];
    userInfoUI.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1].CGColor;
    userInfoUI.layer.borderWidth = 1.0f;
    userInfoUI.center = CGPointMake(SCREEN_WIDTH/2,STATUS_AND_NAVIGATION_HEIGHT+headIcon.frame.size.height+30);
    userInfoUI.layer.cornerRadius = 3;
    [self.view addSubview:userInfoUI];
    
    
    userName = [[UITextField alloc] initWithFrame:CGRectMake(userInfoUI.frame.size.height/2, 0, SCREEN_WIDTH-40-userInfoUI.frame.size.height/2, userInfoUI.frame.size.height/2)];
    userName.placeholder = @"用户名";
    userName.clearButtonMode = UITextFieldViewModeAlways;
    userName.leftViewMode = UITextFieldViewModeAlways;
    //userName.layer.borderColor = [UIColor blackColor].CGColor;
    //userName.layer.borderWidth = 1;
    [userInfoUI addSubview:userName];
    
    UIImageView *userNameImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, userName.frame.size.height, userName.frame.size.height/2)];
    userNameImage.image = [UIImage imageNamed:@"username"];
    userNameImage.contentMode = UIViewContentModeScaleAspectFit;
    userNameImage.center = CGPointMake(userNameImage.frame.size.width/2, userInfoUI.frame.size.height/4);
    [userInfoUI addSubview:userNameImage];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(userInfoUI.frame.size.height/2, userInfoUI.frame.size.height/2, SCREEN_WIDTH-40-userInfoUI.frame.size.height/2, userInfoUI.frame.size.height/2)];
    password.placeholder = @"密码";
    password.secureTextEntry = YES;
   // password.layer.borderColor = [UIColor blackColor].CGColor;
    //password.layer.borderWidth = 1;
    [userInfoUI addSubview:password];
    
    UIImageView *passwordImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, password.frame.size.height, password.frame.size.height/2)];
    passwordImage.image = [UIImage imageNamed:@"password"];
    passwordImage.contentMode = UIViewContentModeScaleAspectFit;
    passwordImage.center = CGPointMake(passwordImage.frame.size.width/2, userInfoUI.frame.size.height/1.4);
    [userInfoUI addSubview:passwordImage];

    
    
    login = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, SCREEN_HEIGHT/18)];
    login.center = CGPointMake(SCREEN_WIDTH/2, userInfoUI.frame.origin.y+userInfoUI.frame.size.height+50);
    [login setTitle:@"登录" forState:UIControlStateNormal];
    login.titleLabel.font = [UIFont systemFontOfSize:15];
    login.backgroundColor = [UIColor colorWithRed:0.32 green:0.74 blue:1 alpha:1];
    login.layer.cornerRadius = 2;
    [login addTarget:self action:@selector(loginClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
}
#pragma mark - 点击登录
-(void)loginClickAction:(id)sender
{
    NSString *userNameContext = userName.text;
    NSString *passwordContext = password.text;
    
    
    
    
    NSLog(@"userNameContext:%@,passwordContext%@",userNameContext,passwordContext);
    
    if ([userNameContext  isEqual: @""]||[passwordContext  isEqual: @""]) {
        
       /* UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不可为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *infoNil = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:infoNil];
        
        [self presentViewController:alertController animated:YES completion:nil];*/
        
        if(nullToast == nil){
        nullToast = [[DSToast alloc] initWithText:@"用户名或密码不可为空"];
            [nullToast show];
        }else{
        
            [nullToast show];
        }
    }else{
        
    NSDictionary *parameter = @{@"mobile": userNameContext,@"password":passwordContext};
      
        
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://localhost:8081/ztcms/mobile/userLogin" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        MBProgressHUD *loginWait = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //loginWait.mode = MBProgressHUDModeAnnularDeterminate;
        loginWait.labelText = @"登录中";

        
        
        if ([[responseObject objectForKey:@"code"] intValue] == 1) {
            [loginWait hide:YES];
           // NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
            NSUserDefaults *nameAndPassword = [NSUserDefaults standardUserDefaults];
            
            //[userInfo setObject:responseObject forKey:@"userMoreInfo"];
            [nameAndPassword setObject:parameter forKey:@"info"];
            
            
            //[userInfo synchronize];
            [nameAndPassword synchronize];
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]]
                                                         animated:YES];
            
        }else{
            [loginWait hide:YES];
            /*UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:[responseObject objectForKey:@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *wrong = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:wrong];
            
            
            
            [self presentViewController:alertController animated:YES completion:nil];*/
            
            if(wrongToast == nil){
                wrongToast = [[DSToast alloc] initWithText:[NSString stringWithFormat:[responseObject objectForKey:@"msg"]]];
                [wrongToast show];
            }else{
                
                [wrongToast show];
            }
            
          
            
        }

        NSLog(@"JSON:+++++++++++++++++ %@",responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error================: %@",error);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器连接失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *errors = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:errors];
        [self presentViewController:alertController animated:YES completion:nil];
       
        }];
        
    }
    
}
#pragma mark - 其他信息
-(void)addBottom
{
    UILabel *rigisterUser = [[UILabel alloc] initWithFrame:CGRectMake(login.frame.origin.x, login.frame.origin.y+login.frame.size.height+10, SCREEN_WIDTH/5,userName.frame.size.height/1.5 )];
    rigisterUser.font = [UIFont systemFontOfSize:12];
    rigisterUser.numberOfLines = 1;
    rigisterUser.adjustsFontSizeToFitWidth = YES;
    [rigisterUser setText:@"注册用户"];
    [rigisterUser setTextColor:[UIColor colorWithRed:0.26 green:0.71 blue:1 alpha:1]];
    rigisterUser.userInteractionEnabled = YES;
    UITapGestureRecognizer *rigisterUserTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClikcRigister)];
    rigisterUserTap.numberOfTapsRequired = 1;
    rigisterUserTap.numberOfTouchesRequired = 1;
    [rigisterUser addGestureRecognizer:rigisterUserTap];
    [self.view addSubview:rigisterUser];
    
    
    UILabel *forgetPassword = [[UILabel alloc] initWithFrame:CGRectMake(login.frame.origin.x+login.frame.size.width-SCREEN_WIDTH/5, login.frame.origin.y+login.frame.size.height+10, SCREEN_WIDTH/5,userName.frame.size.height/1.5)];
    [forgetPassword setText:@"忘记密码?"];
    [forgetPassword setTextColor:[UIColor colorWithRed:0.26 green:0.71 blue:1 alpha:1]];
    forgetPassword.font = [UIFont systemFontOfSize:12];
    forgetPassword.numberOfLines = 1;
    forgetPassword.adjustsFontSizeToFitWidth = YES;
    forgetPassword.textAlignment = NSTextAlignmentRight;
    forgetPassword.userInteractionEnabled = YES;
    UITapGestureRecognizer *forgetPasswordTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClikcForgetPassword)];
    forgetPasswordTap.numberOfTapsRequired = 1;
    forgetPasswordTap.numberOfTouchesRequired = 1;
    [forgetPassword addGestureRecognizer:forgetPasswordTap];
    
    
    [self.view addSubview:forgetPassword];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/1.2, SCREEN_WIDTH, SCREEN_HEIGHT/35)];
    bottomLabel.text = @"**";
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.textColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.8 alpha:1];
    bottomLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bottomLabel];
}

// 点击注册
- (void)onClikcRigister
{
    NSLog(@"..1..");
}

// 点击注册
- (void)onClikcForgetPassword
{
    NSLog(@"...2.");
}



@end
