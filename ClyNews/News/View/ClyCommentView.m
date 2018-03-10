//
//  ClyCommentView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/15.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyCommentView.h"

@implementation ClyCommentView

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
        
        self.backgroundColor = replyCellColor;
        
        [self addLineView];
        [self addTextField];
        [self addDoBtn];
    }
    
    
    return self;
    
}

-(void) addLineView{

    UIView *clineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    clineView.backgroundColor = lineColor;
    [self addSubview:clineView];
}

-(void) addTextField{
    
    UITextField *inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 50) ];
    inputTextField.layer.cornerRadius = 3.0;
    inputTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    inputTextField.layer.borderWidth = 1.0f;
    
    [self addSubview:inputTextField];
    inputTextField.backgroundColor=[UIColor whiteColor];
    _inputTextField = inputTextField;

}

-(void) addDoBtn{
    
    UIButton *doBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    doBtn.frame = CGRectMake(kScreenWidth-70, 65, 60, 20);
    doBtn.layer.cornerRadius = 4.0;
    doBtn.layer.borderWidth = 0.8f;
    doBtn.layer.borderColor = fontHightlightColor.CGColor;
    doBtn.backgroundColor = fontHightlightColor;
    [doBtn setTitle:@"提交" forState:UIControlStateNormal];
    doBtn.titleLabel.font = [UIFont fontWithName:@"HYQiHei" size:12];
    [doBtn setTitleColor:tableWhiteColor forState:UIControlStateNormal];
    [self addSubview:doBtn];

}

@end
