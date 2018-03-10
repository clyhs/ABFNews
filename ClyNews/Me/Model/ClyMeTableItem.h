//
//  ClyMeTableItem.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/3.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClyMeTableItem : NSObject

// 标题
@property (nonatomic, strong) NSString *title;

// 图标
@property (nonatomic, strong) NSString *icon;

@property (nonatomic, strong) NSString *desc;

@property (nonatomic, assign )NSInteger accessoryType;

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon desc:(NSString *)desc;


- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon;

- (instancetype)initWithTitle:(NSString *)title;

@end
