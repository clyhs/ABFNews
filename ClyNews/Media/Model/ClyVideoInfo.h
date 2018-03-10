//
//  ClyVideoInfo.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/15.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ClyUser.h"
@class ClyUser;

@interface ClyVideoInfo : NSObject

@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *suffix;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *videoTime;
@property(nonatomic,copy) NSString *img;

@property(nonatomic,strong) ClyUser *user;


+ (instancetype)videoModelWithDict:(NSDictionary *)dict;

@end
