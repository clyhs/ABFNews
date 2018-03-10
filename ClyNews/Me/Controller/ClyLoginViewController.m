//
//  ClyLoginViewController.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/28.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyLoginViewController.h"
#import "ClyUser.h"
#import "AppDelegate.h"
#import <SVProgressHUD.h>

@interface ClyLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ClyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBasic];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden=YES;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void) addBasic{
    
    
    UIImage *im = [UIImage imageNamed:@"username"];
    UIImageView *iv = [[UIImageView alloc] initWithImage:im];
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 160)];
    iv.center = lv.center;
    [lv addSubview:iv];
    _username.leftViewMode = UITextFieldViewModeAlways;
    _username.leftView = lv;
    _username.text = @"admin";
    
    UIImage *im2 = [UIImage imageNamed:@"password"];
    UIImageView *iv2 = [[UIImageView alloc] initWithImage:im2];
    UIView *lv2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 160)];
    iv2.center = lv2.center;
    [lv2 addSubview:iv2];
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.leftView = lv2;
    _password.secureTextEntry = YES;
    _password.text=@"123456";
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 5.0;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)login:(id)sender {
    
    [SVProgressHUD show];
    
    ClyUser *user = [[ClyUser alloc] init];
    user.username = _username.text;
    user.id = @"1";
    user.img= @"http://www.comke.net/public/upload/user/img2011-12-1616-11-19.jpg";
    
    [AppDelegate APP].user = user;
    NSLog(@"login success");
    
    
    
    NSLog(@"username=%@",_username.text);
    NSLog(@"password=%@",_password.text);
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
