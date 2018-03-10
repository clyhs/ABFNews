//
//  ClyHttpManager.m
//  ClyNews
//
//  Created by 陈立宇 on 16/12/31.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import "ClyHttpManager.h"

@implementation ClyHttpManager

+ (instancetype)manager
{
    ClyHttpManager *mgr = [super manager];
    //NSMutableSet *mgrSet = [NSMutableSet set];
    //mgrSet.set = mgr.responseSerializer.acceptableContentTypes;
    
    //[mgrSet addObject:@"text/html"];
    
    //mgr.responseSerializer.acceptableContentTypes = mgrSet;
    
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    
    return mgr;
}

@end
