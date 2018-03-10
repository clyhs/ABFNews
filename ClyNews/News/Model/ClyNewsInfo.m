//
//  ClyNewsInfo.m
//  ClyNews
//
//  Created by 陈立宇 on 16/12/31.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import "ClyNewsInfo.h"

@implementation ClyNewsInfo

+ (instancetype)newsModelWithDict:(NSDictionary *)dict
{
    ClyNewsInfo *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

-(Boolean) hasImage{

    if([_images isEqualToString:@"http://www.capitalfamily.cn/public/upload/article/cu80_03.gif"]){
        _hasImage = NO;
    }else{
        _hasImage =YES;
    }
    return _hasImage;
}

-(CGFloat) contentheight{
    
    if(!_contentheight){
        
        CGFloat labelWidth = kScreenWidth-20;
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 17)];
        content.text = _shortContent;
        content.font = [UIFont fontWithName:@"HYQiHei" size:14];
        content.numberOfLines = 0;
        CGFloat height = [UILabel getHeightByWidth:labelWidth title:content.text font:content.font];
        _contentheight = height;
    }

    return _contentheight;
}

-(CGFloat) titleHeight{
    
    if(!_titleHeight){
    
        CGFloat labelWidth = kScreenWidth-20;
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 20)];
        content.text = _title;
        content.font = [UIFont fontWithName:@"HYQiHei" size:18];
        content.numberOfLines = 0;
        CGFloat height = [UILabel getHeightByWidth:labelWidth title:content.text font:content.font];
        _titleHeight = height;
    }
    
    return _titleHeight;
}

-(CGFloat) titleImgCellHeight{
    if(!_titleImgCellHeight){
        
        CGFloat labelWidth = kScreenWidth-30-80;
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 20)];
        content.text = _title;
        content.font = [UIFont fontWithName:@"HYQiHei" size:18];
        content.numberOfLines = 0;
        CGFloat height = [UILabel getHeightByWidth:labelWidth title:content.text font:content.font];
        _titleImgCellHeight = height;
    }
    return _titleImgCellHeight;
}

@end
