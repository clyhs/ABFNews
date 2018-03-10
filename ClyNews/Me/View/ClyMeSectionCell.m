//
//  ClyMeSectionCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/21.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyMeSectionCell.h"
#import "ClyMenuView.h"
#import "ClyMeTableItem.h"

@implementation ClyMeSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMenuM:(NSMutableArray *)menuM{
    _menuM = menuM;
    CGFloat width = kScreenWidth / 3 ;
    for(int i=0;i<3;i++){
        ClyMeTableItem *item = _menuM[i];
        NSLog(@"%@",item.title);
        //NSString *title = [_menuM[i] objectForKey:@"title"];
        //NSString *icon  = [_menuM[i] objectForKey:@"icon"];
        
        ClyMenuView *menu = [[ClyMenuView alloc] initWithFrame:CGRectMake(width*i, 0, width, 44) title:item.title image:item.icon];
        [self addSubview:menu];
    }
    NSLog(@"%ld",_menuM.count);

}



@end
