//
//  ClyNewsViewModel.m
//  ClyNews
//
//  Created by 陈立宇 on 16/12/31.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import "ClyNewsViewModel.h"
#import "ClyNewsInfo.h"

@implementation ClyNewsViewModel

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
    _fetchNewsInfoCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForNewsInfoWithUrl:input success:^(NSArray *array) {
                NSArray *arrayM = [ClyNewsInfo mj_objectArrayWithKeyValuesArray:array];
                //NSArray *arrayM = [ClyNewsInfo mj_:array];
                [subscriber sendNext:arrayM];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}
- (void)requestForNewsInfoWithUrl:(NSString *)url success:(void (^)(NSArray *array))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSString *fullUrl = [BaseUrl stringByAppendingString:url];
    NSLog(@"url=%@",fullUrl);
    [[ClyHttpManager manager]GET:fullUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        NSArray *temArray=[responseObject objectForKey:@"data"];
        success(temArray);
        NSLog(@"success");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",error);
        failure(operation,error);
    }];
}

@end
