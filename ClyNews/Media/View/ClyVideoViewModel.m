//
//  ClyVideoViewModel.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/15.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyVideoViewModel.h"
#import "ClyVideoInfo.h"
#import <MJExtension.h>

@implementation ClyVideoViewModel

- (instancetype)init
{
    if (self = [super init]) {
        [self setupRACCommand];
    }
    return self;
}

- (void)setupRACCommand
{
    @weakify(self);
    _fetchVideoInfoCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForVideoInfoWithUrl:input success:^(NSArray *array) {
                //NSArray *arrayM = [ClyVideoInfo objectArrayWithKeyValuesArray:array];
                NSArray *arrayM = [ClyVideoInfo mj_objectArrayWithKeyValuesArray :array];
                [subscriber sendNext:arrayM];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}
- (void)requestForVideoInfoWithUrl:(NSString *)url success:(void (^)(NSArray *array))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSString *fullUrl = [BaseUrl stringByAppendingString:url];
    NSLog(@"url=%@",fullUrl);
    [[ClyHttpManager manager]GET:fullUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *temArray=[responseObject objectForKey:@"data"];
        success(temArray);
        NSLog(@"count=%ld",temArray.count);
        NSLog(@"success");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",error);
        failure(operation,error);
    }];
}

@end
