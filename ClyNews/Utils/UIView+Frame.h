//
//  UIView+Frame.h
//  ClyNews
//
//  Created by 陈立宇 on 16/12/30.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)


// 自己模仿frame写出他的四个属性
@property (nonatomic, assign) CGFloat  x;
@property (nonatomic, assign) CGFloat  y;
@property (nonatomic, assign) CGFloat  width;
@property (nonatomic, assign) CGFloat  height;

- (void)addTapAction:(SEL)tapAction target:(id)target;


@end
