//
//  ClyCommentInfo.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/25.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyCommentInfo.h"
#import "ClyCommentReply.h"
#import <MJExtension.h>

@implementation ClyCommentInfo

+ (NSDictionary *)objectClassInArray{
    return @{
             @"replys" : @"ClyCommentReply"
             };
}

-(CGFloat) contentHeight{
    
    if(!_contentHeight){
    
        CGFloat labelWidth = kScreenWidth-50-20;
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 1)];
        content.text = _content;
        content.font = [UIFont fontWithName:@"HYQiHei" size:13];
        content.numberOfLines = 0;
        CGFloat height = [UILabel getHeightByWidth:labelWidth title:content.text font:content.font];
        NSInteger count = height / 13 ;
        _contentHeight = height + 6*(count+1);
    }
    
    return _contentHeight;
}

-(CGFloat) replyHeight{
    
    if(!_replyHeight){
        CGFloat labelWidth = kScreenWidth-50-20-2 - 10;
        NSInteger replyCount = _replys.count;
        NSArray *replys = [ClyCommentReply mj_objectArrayWithKeyValuesArray:_replys];
        CGFloat nHeight = 0;
        for(NSInteger i=0;i<replyCount;i++){
            ClyCommentReply *reply = replys[i];
            UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 20)];

            NSString *str = [reply.username stringByAppendingString:@":"];
            
            content.text =[str stringByAppendingString:reply.replyContent] ;
            content.font = [UIFont fontWithName:@"HYQiHei" size:13];
            content.numberOfLines = 0;
            CGFloat height = [UILabel getHeightByWidth:labelWidth title:content.text font:content.font];
            nHeight = nHeight + height + 6;
            
        }
        _replyHeight = nHeight;
    }
    
    return _replyHeight;
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
