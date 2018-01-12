//
//  PersonageCenterViewController.m
//  RuiCardTong
//
//  Created by waltz on 15/12/16.
//  Copyright (c) 2015 ztej. All rights reserved.
//

#import "PersonageCenterViewController.h"


@interface PersonageCenterViewController ()
{
    UIView *personageCenterView;
}

@end

@implementation PersonageCenterViewController

-(void)viewDidLoad
{
    personageCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    personageCenterView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:personageCenterView];
}
@end
