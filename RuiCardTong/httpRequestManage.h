//
//  httpRequestManage.h
//  掌厨
//
//  Created by xinguo on 15/11/2.
//  Copyright (c) 2015年 2015-11-1. All rights reserved.
//

#import <Foundation/Foundation.h>


// 表示当前存在这个类
@class httpRequestManage;

typedef void(^httpRequestSuccess) (httpRequestManage *manage, id model);
typedef void (^httpRequestFaile)(httpRequestManage*manage,id model);

@interface httpRequestManage : NSObject

+(httpRequestManage *)shareInstance;

- (void)getMainInfoFood:(int)page andSuccess:(httpRequestSuccess)success andFarile:(httpRequestFaile)faile;

// 时间数据
-(void)getMainTime:(NSString *)Year andMonth:(NSString *)month andDay:(NSString *)day andSuccess:(httpRequestSuccess)success andFaile:(httpRequestFaile)faile;
@end
/*
 instancetype 只能作返回值，不能作参数
 id 可以作返回值，也可以作参数
 */ 