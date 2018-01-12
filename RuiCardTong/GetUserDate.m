//
//  GetUserDate.m
//  RuiCardTong
//
//  Created by waltz on 16/1/14.
//  Copyright © 2016年 ztej. All rights reserved.
//

#import "GetUserDate.h"


@interface GetUserDate()

@property (nonatomic, strong) NSDictionary *netUserDate;

@end

@implementation GetUserDate


- (NSDictionary *)getUserDate:(NSDictionary *)parameter{
    
    
   
    //NSUserDefaults *nameAndPassword = [NSUserDefaults standardUserDefaults];
    //NSDictionary *userInfo = [nameAndPassword o   bjectForKey:@"info"];
    NSDictionary *(^netDate)(NSDictionary *par) = ^(NSDictionary *par)
    {
        NSLog(@"%@",par);

        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:@"http://localhost:8081/ztcms/mobile/userLogin" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject){
            
            if ([[responseObject objectForKey:@"code"] intValue] == 1) {
                _netUserDate = responseObject;
                
                
                //NSLog(@"首页加载数据===_netUserDate%@",_netUserDate);
            }else{
                _netUserDate = responseObject;
                
            }
            
            
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
            
            
        }];
        
        return _netUserDate;
        
    };
    
    NSLog(@"block %@",netDate(parameter));
    
    
    
    return netDate(parameter);
}
@end
