//
//  ClyNewsTitleHeaderView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/11.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyNewsTitleHeaderView.h"
#import "ClyUser.h"

@implementation ClyNewsTitleHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)newsTitleHeaderView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ClyNewsTitleHeaderView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

-(void) setNewsInfo:(ClyNewsInfo *)newsInfo{
    _newsInfo = newsInfo;
    [self addTitleLabel];
    [self addTimeLabel];
    [self addAuthorLabel];
}


- (void) addTitleLabel{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, kScreenWidth, 24)];
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont fontWithName:fontNewName size:18];
    titleLabel.textColor = [UIColor whiteColor];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:_newsInfo.title];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = 0;//缩进
    style.firstLineHeadIndent = 0;
    style.lineSpacing = 2;//行距
    
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    titleLabel.attributedText = text;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
}
- (void) addTimeLabel{
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12+_titleLabel.frame.size.height+10, 80, 20)];
    timeLabel.font = [UIFont fontWithName:fontNewName size:12];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.text = _newsInfo.createTime;
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;
}

- (void) addAuthorLabel{
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*2+60, 12+_titleLabel.frame.size.height+10, 60, 20)];
    aLabel.font = [UIFont fontWithName:fontNewName size:12];
    aLabel.textColor = [UIColor whiteColor];
    aLabel.text = @"admin";
    [self addSubview:aLabel];
    _authorLabel= aLabel;
}

@end
