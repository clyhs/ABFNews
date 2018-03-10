//
//  ClyNetworkTool.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/2.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ClyNetworkTool : AFHTTPSessionManager

+ (instancetype)sharedNetworkTools;
+ (instancetype)sharedNetworkToolsWithoutBaseUrl;


@end
