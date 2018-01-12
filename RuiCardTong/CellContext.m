//
//  CellContext.m
//  RuiCardTong
//
//  Created by waltz on 15/12/14.
//  Copyright (c) 2015 ztej. All rights reserved.
//

#import "CellContext.h"

@implementation CellContext

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
    //定义cell单元格内容
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.frame.size.height/6, SCREEN_WIDTH/3-20, self.frame.size.height/3)];
        
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.frame.size.height+self.frame.size.height/4, SCREEN_WIDTH/3, self.frame.size.height/6)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLab];
        
    }
    
    return self;
}
@end
