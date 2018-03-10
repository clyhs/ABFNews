//
//  ClyMenuTableViewCell.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/30.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyMenuView.h"

@interface ClyMenuTableViewCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray;

@end
