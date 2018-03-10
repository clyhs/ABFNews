//
//  ClyNewsViewController.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/12.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClyNewsViewController : UIViewController

@property(nonatomic,copy) NSString *urlString;

@property(nonatomic,assign) NSInteger index;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,copy) NSString *typeId;

@end
