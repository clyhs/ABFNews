//
//  ClyMeTableViewCell.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/3.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyMeTableItem.h"

@interface ClyMeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property(nonatomic ,strong) ClyMeTableItem *item;

@end
