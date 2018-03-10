//
//  ClyNewsViewModel.h
//  ClyNews
//
//  Created by 陈立宇 on 16/12/31.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClyNewsViewModel : NSObject

@property(nonatomic,strong)RACCommand *fetchNewsInfoCommand;


@end
