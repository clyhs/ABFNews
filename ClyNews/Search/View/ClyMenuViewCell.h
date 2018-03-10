//
//  ClyMenuViewCell.h
//  ClyNews
//
//  Created by 陈立宇 on 17/2/17.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyMenuView.h"

@interface ClyMenuViewCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray;

@end
