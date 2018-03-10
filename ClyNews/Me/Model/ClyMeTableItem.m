//
//  ClyMeTableItem.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/3.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyMeTableItem.h"

@implementation ClyMeTableItem

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon desc:(NSString *)desc
{
    if (self = [super init]) {
        _title = title;
        _icon = icon;
        _desc = desc;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon
{
    if (self = [super init]) {
        _title = title;
        _icon = icon;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [self initWithTitle:title icon:nil]) {
        
    }
    return self;
}


@end
