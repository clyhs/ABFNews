//
//  ClyNewsCommentView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/13.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyNewsCommentView.h"

@implementation ClyNewsCommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
 
    
    if (self = [super initWithFrame:frame]) {
        /* 添加子控件的代码*/
        
        self.backgroundColor = lineColor;
        [self addLineView];
        [self addInputBtn];
        [self addCollectBtn];
        [self addShareBtn];
        //[self addInputLabel];
    }
    
    
    return self;

}

-(void) addLineView{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    lineView.backgroundColor = lineColor;
    [self addSubview:lineView];

}

-(void) addInputBtn{
    
    UIButton *inputBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inputBtn.frame = CGRectMake(20, 10, 150, 25);
    
    inputBtn.backgroundColor = tableWhiteColor;
    inputBtn.layer.cornerRadius = 10.0;//2.0是圆角的弧度，根据需求自己更改
    inputBtn.layer.borderColor = RGB_255(204,204,204).CGColor;
    inputBtn.layer.borderWidth = 1.8f;//设置边框颜色
    [inputBtn setImage:[UIImage imageNamed:@"icon_pen"] forState:UIControlStateNormal];
    inputBtn.imageEdgeInsets = UIEdgeInsetsMake(1, 2, 1, 60);
    [inputBtn setTitle:@"写评论" forState:UIControlStateNormal];
    //button标题的偏移量，这个偏移量是相对于图片的
    inputBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    //设置button正常状态下的标题颜色
    [inputBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    inputBtn.titleLabel.font = [UIFont fontWithName:fontNewName size:12];
    
    [inputBtn addTarget:self action:@selector(onPingLunClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:inputBtn];

}

-(void) addCollectBtn{
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(kScreenWidth-120, 0, 40, 40);
    //collectBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //collectBtn.layer.borderWidth = 1.0f;//设置边框颜色
    [collectBtn setImage:[UIImage imageNamed:@"icon_graystar"] forState:UIControlStateNormal];
    
    [collectBtn setImage:[UIImage imageNamed:@"icon_graystar"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"icon_star"] forState:UIControlStateSelected];
    [collectBtn addTarget:self action:@selector(onCollectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:collectBtn];
    
}

-(void) addShareBtn{
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(kScreenWidth-62, 0, 40, 40);
    //collectBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //collectBtn.layer.borderWidth = 1.0f;//设置边框颜色
    [shareBtn setImage:[UIImage imageNamed:@"icon_grayshare"]  forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(onShareClick:) forControlEvents:UIControlEventTouchUpInside];
    //[shareBtn setImage:[UIImage imageNamed:@"icon_grayshare"] forState:UIControlStateNormal];
    //[shareBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateSelected];
    [self addSubview:shareBtn];
    
}

-(void) onCollectClick:(id) sender{
    UIButton *dingBtn = (UIButton *)sender;
    dingBtn.selected = !dingBtn.selected;
    
    
}

-(void) onPingLunClick:(id) sender{
    NSLog(@"pinglun");
    if ([self.delegate respondsToSelector:@selector(pinglun:)]) {
        [self.delegate pinglun:sender];
    }

}

-(void) onShareClick:(id) sender{
    UIButton *dingBtn = (UIButton *)sender;
    dingBtn.selected = !dingBtn.selected;
    NSLog(@"pinglun");
    if ([self.delegate respondsToSelector:@selector(shareClick:)]) {
        [self.delegate shareClick:sender];
    }
    
}







@end
