//
//  ClyNewsInfo.h
//  ClyNews
//
//  Created by 陈立宇 on 16/12/31.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClyUser.h"

@interface ClyNewsInfo : NSObject

@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *shortContent;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *images;
@property(nonatomic,copy) NSString *hit;

@property(nonatomic,assign) Boolean hasImage;
@property(nonatomic,assign) CGFloat contentheight;
@property(nonatomic,assign) CGFloat titleHeight;
@property(nonatomic,assign) CGFloat titleImgCellHeight;


+ (instancetype)newsModelWithDict:(NSDictionary *)dict;




@end
