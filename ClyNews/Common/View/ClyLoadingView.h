//
//  ClyLoadingView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/8.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClyLoadingView : UIView
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (nonatomic, assign) UIEdgeInsets edgeInset;

+ (void)showLoadingInView:(UIView *)view;

+ (void)showLoadingInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset;

+ (void)hideLoadingForView:(UIView *)view;

+ (void)hideAllLoadingForView:(UIView *)view;

+ (ClyLoadingView *)loadingForView:(UIView *)view;

// 实例方法
+ (instancetype)loadViewFromNib;

- (void)showInView:(UIView *)view;

- (void)hide;


@end
