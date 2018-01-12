//
//  MoneyContextCell.m
//  RuiCardTong
//
//  Created by waltz on 15/12/16.
//  Copyright © 2015年 ztej. All rights reserved.
//

#import "MoneyContextCell.h"

@implementation MoneyContextCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _moneyViewImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/8, self.frame.size.width/10, self.frame.size.width/6, self.frame.size.width/6)];
        [self addSubview:_moneyViewImage];
        _moneyViewtitle = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/6+_moneyViewImage.frame.origin.x+5, self.frame.size.width/10, self.frame.size.width, self.frame.size.width/6)];
        _moneyViewtitle.font = [UIFont systemFontOfSize:18];
        [self addSubview:_moneyViewtitle];
        _moneyViewContext = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/6+_moneyViewImage.frame.origin.x+5, self.frame.size.width/10+_moneyViewImage.frame.size.height, self.frame.size.width-_moneyViewtitle.frame.origin.x, self.frame.size.width/6)];
        _moneyViewContext.font = [UIFont systemFontOfSize:13];
        _moneyViewContext.textColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1];
        [self addSubview:_moneyViewContext];
    }
    
    return self;
}
@end
