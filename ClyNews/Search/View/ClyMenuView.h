//
//  ClyMenuView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/30.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClyMenuView : UIView

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr;

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr imageWidth:(CGFloat) width;

-(id)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)imageStr;

@end
