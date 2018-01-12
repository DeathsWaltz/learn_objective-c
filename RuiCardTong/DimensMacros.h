//
//  DimensMacros.h
//  RuiCardTong
//
//  Created by waltz on 15/12/5.
//  Copyright  2015 ztej. All rights reserved.
//

#ifndef DimensMacros_h
#define DimensMacros_h

//状态栏高度
#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44
//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))


//广告栏高度
#define BANNER_HEIGHT 215

#define STYLEPAGE_HEIGHT 21

#define SMALLTV_HEIGHT 77

#define SMALLTV_WIDTH 110

#define FOLLOW_HEIGHT 220

#define SUBCHANNEL_HEIGHT 62





// 是否iPhone5
#define isiPhone5               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
                                 CGSizeEqualToSize(CGSizeMake(640, 1136), \
                                                   [[UIScreen mainScreen] currentMode].size) : \
                                 NO)
//是否是 iphone4
#define isiPhone4               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
                                 CGSizeEqualToSize(CGSizeMake(640, 960), \
                                                   [[UIScreen mainScreen] currentMode].size) : \
                                 NO)
// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//ios7坐标系跟以下适配成 IOS6坐标样式----在 NAV 状态下--存在于从上往下
#define  RECT_NAV_POINT(id,X,Y,W,H)   (FSystemVersion >= 7.0)?\
[id setFrame: CGRectMake(X, Y + 60, W, H)] : \
[id setFrame: CGRectMake(X, Y, W, H)]

#define  RECT_NAV_RECT(id,rect)   (FSystemVersion >= 7.0)?\
[id setFrame: CGRectMake(rect.origin.x, rect.origin.y + 60, rect.size.width, rect.size.height)] : \
[id setFrame: rect]



#endif /* DimensMacros_h */
