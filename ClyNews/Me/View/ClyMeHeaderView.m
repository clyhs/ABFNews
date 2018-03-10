//
//  ClyMeHeaderView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/3.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyMeHeaderView.h"

@implementation ClyMeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    //[self setLoginBtn];
    [self setUserImgView];
    [self setUsernameLabel];
    [self addMenuView];
}

-(void) setUserImgView{
    _userImgView.layer.borderColor = [UIColor blackColor].CGColor;
    _userImgView.layer.borderWidth = 2.0f;
    _userImgView.layer.borderColor = tableWhiteColor.CGColor;
    _userImgView.frame = CGRectMake(kScreenWidth/2-55/2, 135/2-55/2, 55, 55);
    _userImgView.layer.masksToBounds = YES;
    _userImgView.layer.cornerRadius = 55*0.5;
    
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginAction:)];
    //[self addGestureRecognizer:tap];
    
}


-(void) setLoginBtn{
    
    _loginBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _loginBtn.layer.borderWidth = 2.0f;
    _loginBtn.layer.borderColor = tableWhiteColor.CGColor;
    _loginBtn.frame = CGRectMake(kScreenWidth/2-54/2, 135/2-54/2, 54, 54);
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 54*0.5;
}

-(void) setUsernameLabel{
    _usernameLabel.font = [UIFont fontWithName:@"HYQiHei" size:14];
    _usernameLabel.textColor = tableWhiteColor;
    _usernameLabel.textAlignment = NSTextAlignmentCenter;
}

-(void) addMenuView{
    
    CGFloat width = kScreenWidth/3;
    CGFloat height= 44;
    _menuView.backgroundColor = lineColor;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.backgroundColor = cellColor;
    
    UIImageView *icon1 = [[UIImageView alloc] initWithFrame:CGRectMake(width*1/6-5, 10, 22, 22)];
    [icon1 setImage:[UIImage imageNamed:@"icon_message"] ];
    [view1 addSubview:icon1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(width*1/3, 12, width*1.5/3, 20)];
    label1.text = @"消息";
    label1.textColor = fontColor;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont fontWithName:fontNewName size:13];
    [view1 addSubview:label1];
    
   
    
    [_menuView addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    view2.backgroundColor = cellColor;
    
    UIImageView *icon2 = [[UIImageView alloc] initWithFrame:CGRectMake(width*1/6-5, 10, 22, 22)];
    [icon2 setImage:[UIImage imageNamed:@"icon_star"] ];
    [view2 addSubview:icon2];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(width*1/3, 12, width*1.5/3, 20)];
    label2.text = @"收藏";
    label2.textColor = fontColor;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont fontWithName:fontNewName size:13];
    [view2 addSubview:label2];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.8, 44)];
    lineView1.backgroundColor = lineColor;
    [view2 addSubview:lineView1];
    
    [_menuView addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(width+width, 0, width, height)];
    view3.backgroundColor = cellColor;
    
    UIImageView *icon3 = [[UIImageView alloc] initWithFrame:CGRectMake(width*1/6-5, 10, 22, 22)];
    [icon3 setImage:[UIImage imageNamed:@"icon_money"] ];
    [view3 addSubview:icon3];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(width*1/3, 12, width*1.5/3, 20)];
    label3.text = @"金币";
    label3.textColor = fontColor;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont fontWithName:fontNewName size:13];
    [view3 addSubview:label3];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.8, 44)];
    lineView2.backgroundColor = lineColor;
    [view3 addSubview:lineView2];
    [_menuView addSubview:view3];
    
    
}


/*
- (IBAction)loginAction:(id)sender {
    
    NSLog(@"clymeheaderview...");
    if ([self.delegate respondsToSelector:@selector(clickLogin)]) {
        [self.delegate clickLogin];
    }
}*/

-(void) loginAction:(UITapGestureRecognizer *)sender{

    NSLog(@"clymeheaderview...");
    if ([self.delegate respondsToSelector:@selector(clickLogin)]) {
        [self.delegate clickLogin];
    }
}


@end
