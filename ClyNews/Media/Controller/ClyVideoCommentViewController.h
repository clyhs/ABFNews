//
//  ClyVideoCommentViewController.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/20.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyVideoInfo.h"
//@class ClyVideoInfo;

@interface ClyVideoCommentViewController : UIViewController

@property(nonatomic,strong) ClyVideoInfo *videoInfo;

@property(nonatomic,strong) NSString *sTitle;

@property(nonatomic,strong) UITableView *tableView;

@end
