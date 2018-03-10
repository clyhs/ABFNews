//
//  ClyTitleFooterSectionView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/12.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyTitleFooterSectionView.h"

@interface ClyTitleFooterSectionView()

@property (nonatomic, weak) UIButton *button;

@end

@implementation ClyTitleFooterSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self addTitleLabel];
    }
    return self;
}

- (void)addTitleLabel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:fontHightlightColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClikedAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    _button = button;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_button setTitle:title forState:UIControlStateNormal];
}

- (void)buttonClikedAction
{
    if (_clickedHandle) {
        _clickedHandle();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _button.frame = self.bounds;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
