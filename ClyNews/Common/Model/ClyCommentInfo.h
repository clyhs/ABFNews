//
//  ClyCommentInfo.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/25.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ClyUser;


@interface ClyCommentInfo : NSObject

@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *createTime;

@property(nonatomic,copy) NSString *hit;

@property(nonatomic,strong) ClyUser *user;

@property(nonatomic,strong) NSArray *replys;

@property(nonatomic,assign) CGFloat contentHeight;
@property(nonatomic,assign) CGFloat replyHeight;

@end


