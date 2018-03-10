//
//  ClyMJRefreshGifHeader.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/2.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyMJRefreshGifHeader.h"

@implementation ClyMJRefreshGifHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    ClyMJRefreshGifHeader *header = [super headerWithRefreshingTarget:target refreshingAction:action];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    NSMutableArray *refreshingImages  = [NSMutableArray array];
    for (int i = 1; i< 5; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d",i]];
        [refreshingImages addObject:image];
    }
    [header setImages:@[refreshingImages.firstObject] forState:MJRefreshStateIdle];
    [header setImages:@[refreshingImages.firstObject] forState:MJRefreshStatePulling];
    [header setImages:[refreshingImages copy] forState:MJRefreshStateRefreshing];
    return header;
}


@end
