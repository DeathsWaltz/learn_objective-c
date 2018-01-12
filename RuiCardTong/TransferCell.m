
//
//  TransferCell.m
//  RuiCardTong
//
//  Created by waltz on 15/12/23.
//  Copyright (c) 2015 ztej. All rights reserved.
//

#import "TransferCell.h"

@implementation TransferCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
       
        _contextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, SCREEN_HEIGHT/15)];
        _contextView.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1].CGColor;
        _contextView.layer.borderWidth = 1;
        _contextView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contextView];

    }
    
    return self;
    
}



@end
