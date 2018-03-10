//
//  UIImage+ClyImage.h
//  ClyNews
//
//  Created by 陈立宇 on 17/2/16.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ClyImage)


- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height;

/**
 *  用color生成image
 *
 *  @param color 颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  改变image透明度
 *
 *  @param alpha 透明度
 */
- (UIImage *)imageWithAlpha:(CGFloat)alpha;

@end
