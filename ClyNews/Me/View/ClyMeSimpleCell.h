//
//  ClyMeSimpleCell.h
//  ClyNews
//
//  Created by 陈立宇 on 17/2/21.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyMeTableItem.h"

@interface ClyMeSimpleCell : UITableViewCell

@property(nonatomic,strong) ClyMeTableItem *meItem;

-(void) setMeItem:(ClyMeTableItem *)meItem desc:(NSString *)desc;

@end
