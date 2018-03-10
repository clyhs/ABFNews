//
//  ClyCommentReply.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/12.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyCommentReply.h"

@implementation ClyCommentReply

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [self mj_encode:aCoder];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self= [super init]) {
        [self mj_decode:aDecoder];
    }
    return self;
}

@end
