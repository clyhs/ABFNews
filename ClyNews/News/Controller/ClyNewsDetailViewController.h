//
//  ClyNewsDetailViewController.h
//  ClyNews
//
//  Created by 陈立宇 on 17/2/10.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyNewsInfo.h"

@interface ClyNewsDetailViewController : UIViewController

@property(nonatomic,strong) ClyNewsInfo *newsInfo;

@property(nonatomic,strong) UITableView *tableView;

@end
