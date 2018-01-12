//
//  MenuDelegate.h
//  RuiCardTong
//
//  Created by waltz on 15/12/7.
//  Copyright  2015 ztej. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface MenuDelegate : UIResponder<UIApplicationDelegate, RESideMenuDelegate>
@property (strong,nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;
@end
