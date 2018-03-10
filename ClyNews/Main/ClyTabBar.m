//
//  ClyTabBar.m
//  ClyNews
//
//  Created by 陈立宇 on 16/12/30.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import "ClyTabBar.h"
#import "ClyBarButton.h"

@interface ClyTabBar ()

@property(nonatomic,strong) ClyBarButton *selButton;
@property(nonatomic,strong) UIImageView *imgView;

@end


@implementation ClyTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)addImageView
{
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@""];
    self.imgView = imgView;
    [self addSubview:imgView];
}

#pragma mark - /************************* 通过传入数据赋值图片 ***************************/
- (void)addBarButtonWithNorName:(NSString *)nor andDisName:(NSString *)dis andTitle:(NSString *)title
{
    ClyBarButton *btn = [[ClyBarButton alloc]init];
    
    [btn setImage:[UIImage imageNamed:nor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:dis] forState:UIControlStateDisabled];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:RGB_255(23,158,246) forState:UIControlStateDisabled];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
    
    // 让第一个按钮默认为选中状态
    if (self.subviews.count == 2) {
        btn.tag = 1;
        [self btnClick:btn];
    }
}


#pragma mark - /************************* 动态加载时设置frame值 ***************************/
- (void)layoutSubviews
{
    UIImageView *imgView = self.subviews[0];
    imgView.frame = self.bounds;
    
    for (int i = 1; i<self.subviews.count; i++) { // $$$$$
        
        UIButton *btn = self.subviews[i];
        
        //        CGFloat btnW = self.frame.size.width/self.subviews.count;
        //        CGFloat btnH = self.frame.size.height;
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width/4;
        CGFloat btnH = 49;
        CGFloat btnX = (i-1) * btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        // 绑定tag 便于后面使用
        btn.tag = i-1;
    }
}

#pragma mark - /************************* 按钮点下方法 ***************************/
- (void)btnClick:(ClyBarButton *)btn
{
    
    // 响应代理方法 实现页面跳转
    if ([self.delegate respondsToSelector:@selector(ChangSelIndexForm:to:)]) {
        [self.delegate ChangSelIndexForm:_selButton.tag to:btn.tag];
    }
    
    // 设置按钮显示状态 并切换选中按钮
    _selButton.enabled = YES;
    _selButton = btn;
    btn.enabled = NO;
}


@end
