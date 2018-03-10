//
//  ClyDownloadedCell.h
//  ClyNews
//
//  Created by 陈立宇 on 17/3/7.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyFileInfo.h"

@interface ClyDownloadedCell : UITableViewCell

@property(nonatomic,strong) UIImageView *fileImageIcon;

@property(nonatomic,strong) UILabel *filenameLabel;

@property(nonatomic,strong) UILabel *filesizeLabel;

@property(nonatomic,strong) ClyFileInfo *fileInfo;

@end
