//
//  httpRequestManage.m
//  掌厨
//
//  Created by xinguo on 15/11/2.
//  Copyright (c) 2015年 2015-11-1. All rights reserved.
//

#import "httpRequestManage.h"
//#import "NetInterface.h"
#import "AFNetworking.h"
//#import "MainModel.h"

@implementation httpRequestManage

// 实例化一个单例
+(httpRequestManage*)shareInstance
{
    static httpRequestManage *mange = nil;
    // 在整个程序生命周期方法只调用一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mange = [[httpRequestManage alloc]init];
    });
    return mange;
}

-(void)getMainInfoFood:(int)page andSuccess:(httpRequestSuccess)success andFarile:( httpRequestFaile )faile
{
    NSString *url = [NSString stringWithFormat:@"http://localhost:8081/ztcms/mobile/userLogin"];
    NSLog(@"%@",url);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableLeaves error:nil];
        // NSJSONReadingMutableLeaves 返回的数据是不可变的
        // NSJSONReadingMutableContainers 返回回来的数据是可变的
//        NSLog(@"%@",dic);
        
        
        // 实例化
        MainModel *model = [[MainModel alloc]init];
        model.Data = dic[@"data"];
        
        success(self,model); // 调用成功的代码块
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        faile(self,error);
        
        NSLog(@"error %@",[error localizedDescription]);
    }];
}



-(void)getMainTime:(NSString *)Year andMonth:(NSString *)month andDay:(NSString *)day andSuccess:(httpRequestSuccess)success andFaile:(httpRequestFaile)faile
{
    // 传数据回来
    NSString *url = [NSString stringWithFormat:kMainDate_Url,Year,month,day];
//    NSLog(@"%@",url);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@",dic);
        MainModel *model = [[MainModel alloc]init];
        model.Data = dic[@"data"];
        success(self,model);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",[error localizedDescription]);
        faile(self,error);
    }];
}


@end
