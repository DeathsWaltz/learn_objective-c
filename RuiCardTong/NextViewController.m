//
//  NextViewController.m
//  RuiCardTong
//
//  Created by waltz on 15/12/14.
//  Copyright © 2015年 ztej. All rights reserved.
//

#import "NextViewController.h"

@implementation NextViewController

-(void)viewDidLoad
{

    UIView *nextview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) ];
    nextview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nextview];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [webView loadRequest:request];
    [nextview addSubview:webView];
}
@end
