//
//  ClyMainTabBarController.m
//  ClyNews
//
//  Created by 陈立宇 on 16/12/29.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import "ClyMainTabBarController.h"
#import "ClyMainViewController.h"
#import "ClyBarButton.h"
#import "ClyTabBar.h"
#import "ClyNavController.h"

@interface ClyMainTabBarController ()<ClyTabBarDelegate>

@end

@implementation ClyMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"update"];
    
    ClyTabBar *tabBar = [[ClyTabBar alloc]init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    [self.tabBar addSubview:tabBar];
    
    tabBar.delegate = self;
    
    
    [tabBar addImageView];
    
    [tabBar addBarButtonWithNorName:@"tabbar_news_normal" andDisName:@"tabbar_news_highlight" andTitle:@"新闻"];
    [tabBar addBarButtonWithNorName:@"tabbar_media_normal" andDisName:@"tabbar_media_highlight" andTitle:@"视听"];
    [tabBar addBarButtonWithNorName:@"tabbar_found_normal" andDisName:@"tabbar_found_highlight" andTitle:@"发现"];
    [tabBar addBarButtonWithNorName:@"tabbar_me_normal" andDisName:@"tabbar_me_highlight" andTitle:@"我"];
    
    self.selectedIndex = 0;
}

#pragma mark - ******************** SXTabBarDelegate代理方法
- (void)ChangSelIndexForm:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
