//
//  ClyAroundInfo.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/29.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClyAroundInfo : NSObject

@property(nonatomic, strong) NSString *mname;//标题
@property(nonatomic, strong) NSNumber *price;//价格
@property(nonatomic, strong) NSString *imgurl;//图片

@property(nonatomic, strong) NSMutableArray *rdplocs;//坐标等

@end
