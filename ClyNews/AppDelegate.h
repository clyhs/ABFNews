//
//  AppDelegate.h
//  ClyNews
//
//  Created by 陈立宇 on 16/12/29.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyUser.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ClyUser *user;

+(AppDelegate*)APP;

@end

