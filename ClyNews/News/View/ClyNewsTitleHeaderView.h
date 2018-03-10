//
//  ClyNewsTitleHeaderView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/2/11.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyNewsInfo.h"

@interface ClyNewsTitleHeaderView : UIView

@property (weak, nonatomic)  UILabel *titleLabel;
@property (weak, nonatomic)  UILabel *timeLabel;
@property (weak, nonatomic)  UILabel *authorLabel;

@property (nonatomic,strong) ClyNewsInfo *newsInfo;

+(instancetype)newsTitleHeaderView;

@end
