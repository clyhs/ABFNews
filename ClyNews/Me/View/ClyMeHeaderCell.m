//
//  ClyMeHeaderCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/21.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyMeHeaderCell.h"

@interface ClyMeHeaderCell()



@end

@implementation ClyMeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 135)];
        topView.backgroundColor = navigationBarColor;
        [self addSubview:topView];
        _topView = topView;
        
        [self addLoginBtn];
        [self addUsernameLabel];
        
        UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 135, kScreenWidth, 44)];
        menuView.backgroundColor = cellColor;
        [self addSubview:menuView];
        _menuView = menuView;
        
        [self addMenuView];
    }
    return self;
}

-(void) addLoginBtn{
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.layer.borderColor = [UIColor blackColor].CGColor;
    loginBtn.layer.borderWidth = 2.0f;
    loginBtn.layer.borderColor = tableWhiteColor.CGColor;
    loginBtn.frame = CGRectMake(kScreenWidth/2-54/2, 135/2-54/2, 54, 54);
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 54*0.5;
    [loginBtn setImage:[UIImage imageNamed:@"me_default_header"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_topView addSubview:loginBtn];
    _loginBtn = loginBtn;
    
}

-(void) addUsernameLabel{
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 135/2 + 54/2 + 8 , 100, 25)];
    userLabel.font = [UIFont fontWithName:@"HYQiHei" size:14];
    userLabel.textColor = tableWhiteColor;
    userLabel.text=@"请登录";
    userLabel.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:userLabel];
    _usernameLabel = userLabel;
    
   
}

-(void) addMenuView{
    
    CGFloat width = kScreenWidth/3;
    CGFloat height= 44;
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(width*1/3, 12, width*2/3, 20)];
    label1.text = @"消息";
    label1.textColor = fontColor;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont fontWithName:fontNewName size:13];
    [view1 addSubview:label1];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(width-0.2, 0, 0.8, 44)];
    lineView1.backgroundColor = lineColor;
    [view1 addSubview:lineView1];
    
    [_menuView addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(width*1/3, 12, width*2/3, 20)];
    label2.text = @"订阅";
    label2.textColor = fontColor;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont fontWithName:fontNewName size:13];
    [view2 addSubview:label2];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(width-0.2, 0, 0.8, 44)];
    lineView2.backgroundColor = lineColor;
    [view2 addSubview:lineView2];
    
    [_menuView addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(width+width, 0, width, height)];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(width*1/3, 12, width*2/3, 20)];
    label3.text = @"任务";
    label3.textColor = fontColor;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont fontWithName:fontNewName size:13];
    [view3 addSubview:label3];
    [_menuView addSubview:view3];


}

-(void)loginClick:(id)sender{

    NSLog(@"clymeheaderview...");
    if ([self.delegate respondsToSelector:@selector(clickLogin)]) {
        [self.delegate clickLogin];
    }
}

@end
