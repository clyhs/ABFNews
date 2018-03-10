//
//  UIView+Nib.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/3.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Nib)

/**
 *  加载nib
 */
+ (UINib *)loadNib;

/**
 *  加载nib
 *
 *  @param nibName nib名字
 */
+ (UINib *)loadNibNamed:(NSString*)nibName;

/**
 *  加载nib
 *
 *  @param nibName nib名字
 *  @param bundle  nib文件包（目录）
 */
+ (UINib *)loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;


/**
 *  加载nib生成view
 */
+ (instancetype)loadInstanceFromNib;

/**
 *  加载nib生成view
 *
 *  @param nibName nib名字
 */
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName;

/**
 *   加载nib生成view
 *
 *  @param nibName nib名字
 *  @param owner   nib文件的File's Owner
 */
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;

/**
 *  加载nib生成view
 *
 *  @param nibName nib名字
 *  @param owner   nib文件的File's Owner
 *  @param bundle  nib文件包（目录）
 */
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;


@end
