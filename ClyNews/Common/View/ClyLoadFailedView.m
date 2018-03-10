//
//  ClyLoadFailedView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/8.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyLoadFailedView.h"

@implementation ClyLoadFailedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)loadViewFromNib
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _edgeInset = UIEdgeInsetsZero;
}

#pragma mark - action
- (IBAction)retryAction:(id)sender {
    
    if (_retryHandle) {
        _retryHandle();
    }
    [self hide];
}

#pragma mark - 便利方法

+ (void)showLoadFailedInView:(UIView *)view
{
    [self showLoadFailedInView:view edgeInset:UIEdgeInsetsZero];
}

+ (void)showLoadFailedInView:(UIView *)view retryHandle: (void (^)(void))retryHandle
{
    [self showLoadFailedInView:view edgeInset:UIEdgeInsetsZero retryHandle:retryHandle];
}

+ (void)showLoadFailedInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset
{
    [self showLoadFailedInView:view edgeInset:edgeInset retryHandle:nil];
}

+ (void)showLoadFailedInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset retryHandle: (void (^)(void))retryHandle
{
    ClyLoadFailedView *loadFailedView = [self loadViewFromNib];
    
    loadFailedView.edgeInset = edgeInset;
    loadFailedView.retryHandle = retryHandle;
    
    [loadFailedView showInView:view];
}

+ (void)hideLoadFailedForView:(UIView *)view
{
    ClyLoadFailedView *loadFailedView = [self loadFailedForView:view];
    if (loadFailedView) {
        [loadFailedView hide];
    }
}

+ (ClyLoadFailedView *)loadFailedForView:(UIView *)view
{
    NSEnumerator *reverseSubviews = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in reverseSubviews) {
        if ([subview isKindOfClass:self]) {
            return (ClyLoadFailedView *)subview;
        }
    }
    return nil;
}

#pragma mark - 实例方法

- (void)showInView:(UIView *)view
{
    if (!view) {
        return ;
    }
    if (self.superview != view) {
        
        [self removeFromSuperview];
        
        [view addSubview:self];
        
        [view bringSubviewToFront:self];
        
        [self addConstraintInView:view edgeInset:_edgeInset];
    }
}

- (void)addConstraintInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:edgeInset.top]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:edgeInset.left]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:edgeInset.right]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:edgeInset.bottom]];
}

- (void)hide
{
    self.alpha = 1.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
