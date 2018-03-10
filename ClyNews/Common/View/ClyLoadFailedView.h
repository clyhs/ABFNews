//
//  ClyLoadFailedView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/8.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClyLoadFailedView : UIView
@property (weak, nonatomic) IBOutlet UIButton *retryBtn;
@property (weak, nonatomic) IBOutlet UILabel *failedTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *retryTitleLabel;


@property (nonatomic, assign) UIEdgeInsets edgeInset;

@property (nonatomic, copy) void (^retryHandle)(void);

+ (void)showLoadFailedInView:(UIView *)view;

+ (void)showLoadFailedInView:(UIView *)view retryHandle: (void (^)(void))retryHandle;

+ (void)showLoadFailedInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset;

+ (void)showLoadFailedInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset retryHandle: (void (^)(void))retryHandle;

+ (void)hideLoadFailedForView:(UIView *)view;

+ (ClyLoadFailedView *)loadFailedForView:(UIView *)view;

- (void)showInView:(UIView *)view;

- (void)hide;

@end
