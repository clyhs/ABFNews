//
//  ClyMeSimpleCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/21.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyMeSimpleCell.h"

@interface ClyMeSimpleCell()

@property(nonatomic,weak) UIView *sView;

@end

@implementation ClyMeSimpleCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setMeItem:(ClyMeTableItem *)meItem{
    _meItem = meItem;
    
    [self addSView];
    [self addIcon];
    [self addTitle];

}

-(void) setMeItem:(ClyMeTableItem *)meItem desc:(NSString *)desc{
    
    _meItem = meItem;

    [self addSView];
    [self addIcon];
    [self addTitle];
    [self addDesc];
}

-(void) addSView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44-0.2, kScreenWidth, 0.8)];
    lineView.backgroundColor = lineColor;
    [view addSubview:lineView];
    [self addSubview:view];
    _sView = view;
    
}


-(void) addIcon{
    
    UIImageView *iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 13, 20, 20)];
    [iconImg setImage:[UIImage imageNamed:_meItem.icon]];
    [_sView addSubview:iconImg];

}

-(void) addTitle{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 12, 60, 20)];
    titleLabel.font = [UIFont fontWithName:fontNewName size:13];
    titleLabel.textColor = fontColor;
    titleLabel.text = _meItem.title;
    [_sView addSubview:titleLabel];
}

-(void) addDesc{
    
    UILabel *dLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-80, 12, 50, 20)];
    dLabel.font = [UIFont fontWithName:fontNewName size:12];
    dLabel.textColor = fontHightlightColor;
    dLabel.text = _meItem.desc;
    dLabel.textAlignment = NSTextAlignmentRight;
    [_sView addSubview:dLabel];

}

@end
