//
//  ClyTitleLabel.m
//  ClyNews
//
//  Created by 陈立宇 on 16/12/29.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import "ClyTitleLabel.h"

@implementation ClyTitleLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont fontWithName:fontName size:16];
        
        self.scale = 0.0;
        
        [self addLineView];
        _lineView.hidden = YES;
        
    }
    return self;
}

/** 通过scale的改变改变多种参数 */
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    //NSLog(@"scale=%f",_scale);
    
    self.textColor = RGB_255(_scale*23,_scale*158,_scale*246);
    
    CGFloat minScale = 1.0;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

- (void) addLineView{

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, 36, 50, 2)];
    lineView.backgroundColor = navigationBarColor;
    [self addSubview:lineView];
    _lineView = lineView;
}

@end
