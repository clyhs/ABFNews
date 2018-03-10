//
//  ClyMJRefreshGifFooter.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/2.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyMJRefreshGifFooter.h"

@implementation ClyMJRefreshGifFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action{

    ClyMJRefreshGifFooter *footer = [super footerWithRefreshingTarget:target refreshingAction:action];
    footer.stateLabel.hidden = YES;
    
    NSMutableArray *refreshingImages  = [NSMutableArray array];
    for (int i = 1; i< 5; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d",i]];
        [refreshingImages addObject:image];
    }
    [footer setImages:@[refreshingImages.firstObject] forState:MJRefreshStateIdle];
    [footer setImages:@[refreshingImages.firstObject] forState:MJRefreshStatePulling];
    [footer setImages:[refreshingImages copy] forState:MJRefreshStateRefreshing];
    
  
    return footer;

}

@end
