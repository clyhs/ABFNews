//
//  ClyTitleSectionView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/11.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyTitleSectionView.h"

@interface ClyTitleSectionView()

@property (nonatomic, weak) UIView *leftLineView;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation ClyTitleSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = RGB_255(236, 236, 236);
        
        [self addLeftLineView];
        
        [self addTitleLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.contentView.backgroundColor = RGB_255(236, 236, 236);
        
        [self addLeftLineView];
        
        [self addTitleLabel];
        
    }
    return self;
}

- (void)addLeftLineView
{
    UIView *leftLineView = [[UIView alloc]init];
    leftLineView.backgroundColor = RGB_255(30,144,255);
    [self.contentView addSubview:leftLineView];
    _leftLineView = leftLineView;
}

- (void)addTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = RGB_255(155, 155, 155);
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat edging = 6;
    _leftLineView.frame = CGRectMake(12, edging, 3, CGRectGetHeight(self.frame)-2*edging);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_leftLineView.frame)+8, 0, 200, CGRectGetHeight(self.frame));
    
}

@end
