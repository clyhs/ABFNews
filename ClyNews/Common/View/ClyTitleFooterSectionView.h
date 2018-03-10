//
//  ClyTitleFooterSectionView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/2/12.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClyTitleFooterSectionView : UITableViewHeaderFooterView

@property(nonatomic,strong) NSString *title;

@property (nonatomic, copy) void (^clickedHandle)(void);

@end
