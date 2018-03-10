//
//  ClyNavigationBarView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/24.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyNavigationBarView.h"

@interface ClyNavigationBarView()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation ClyNavigationBarView

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 15, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:fontNewName size:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = title;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha
{
    _backgroundAlpha = backgroundAlpha;
    if (_backgroundView) {
        _backgroundView.alpha = backgroundAlpha;
    }
}


- (IBAction)navBack:(id)sender {
    if (_navBackHandle) {
        _navBackHandle();
    }else {
        UIViewController *VC = [self viewController];
        if (VC && VC.navigationController) {
            [VC.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next =
         next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
