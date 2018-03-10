//
//  ClyVideoInfo.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/15.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyVideoInfo.h"
#import <MJExtension.h>

@implementation ClyVideoInfo


+ (instancetype)videoModelWithDict:(NSDictionary *)dict
{
    ClyVideoInfo *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

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
