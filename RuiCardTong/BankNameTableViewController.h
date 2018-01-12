//
//  BankNameTableViewController.h
//  RuiCardTong
//
//  Created by waltzdeath on 16/1/3.
//  Copyright © 2016年 ztej. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransferViewController.h"
typedef void(^SUIBankNameBlock)(NSString *bankName);

@interface BankNameTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)NSString *bankName;

@property (nonatomic,copy) SUIBankNameBlock backNameBlock;

@end
