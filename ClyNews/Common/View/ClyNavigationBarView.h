//
//  ClyNavigationBarView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/24.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClyNavigationBarView : UIView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) void (^navBackHandle)(void);

@property (nonatomic, assign) CGFloat backgroundAlpha;

@end
