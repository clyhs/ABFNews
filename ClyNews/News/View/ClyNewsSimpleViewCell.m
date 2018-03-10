//
//  ClyNewsSimpleViewCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/12.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyNewsSimpleViewCell.h"

@interface ClyNewsSimpleViewCell()

@property(nonatomic,weak) UIView *sView;

@end

static NSInteger newsMargin = 10;
static NSInteger newsImgHeight = 40;
static NSInteger newsImgWidth  = 40;
static NSInteger newsTitleSize = 18;
static NSInteger newsShortSize = 12;
static NSInteger newsContentAndTimeMargin = 5;
static NSInteger newsTimeAndHitHeight = 18;

@implementation ClyNewsSimpleViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setNewsInfo:(ClyNewsInfo *)newsInfo {

    _newsInfo = newsInfo;
    self.backgroundColor = tableWhiteColor;

    [self addSView];
    [self addTitleLabel];
    [self addContentLabel];
    [self addTimeAndHit];
}

-(void) addSView{
    
    CGFloat viewHeight = 1.5*newsMargin+_newsInfo.titleHeight+_newsInfo.contentheight+newsContentAndTimeMargin+newsTimeAndHitHeight+10;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, viewHeight)];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight-0.2, kScreenWidth, 0.8)];
    lineView.backgroundColor = lineColor;
    [view addSubview:lineView];
    [self addSubview:view];
    _sView = view;

}

-(void) addTitleLabel{
    
    
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(newsMargin, 0.8*newsMargin, kScreenWidth-newsMargin*2, _newsInfo.titleHeight)];
    tLabel.font = [UIFont fontWithName:fontNewName size:16];
    tLabel.text = _newsInfo.title;
    tLabel.textColor = fontColor;
    [_sView addSubview:tLabel];

}

-(void) addContentLabel{

    UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(newsMargin, 1.5*newsMargin+_newsInfo.titleHeight, kScreenWidth-2*newsMargin, _newsInfo.contentheight)];
    cLabel.font = [UIFont fontWithName:fontNewName size:13];
    cLabel.numberOfLines = 0;
    cLabel.textColor = [UIColor lightGrayColor];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:_newsInfo.shortContent];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = 0;//缩进
    style.firstLineHeadIndent = 20;
    style.lineSpacing = 2;//行距
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    cLabel.attributedText = text;
    [_sView addSubview:cLabel];
    
}
-(void) addTimeAndHit {
    
    UILabel *sLabel = [[UILabel alloc] initWithFrame:CGRectMake(newsMargin,2*newsMargin+_newsInfo.titleHeight+_newsInfo.contentheight+newsContentAndTimeMargin, 80, newsTimeAndHitHeight)];
    sLabel.font = [UIFont fontWithName:fontNewName size:12];
    sLabel.textColor = RGB_255(30, 130, 245);
    sLabel.text = _newsInfo.createTime;
    [_sView addSubview:sLabel];
    
    UILabel *hLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-60, 2*newsMargin+_newsInfo.titleHeight+_newsInfo.contentheight+newsContentAndTimeMargin, 50, newsTimeAndHitHeight)];
    hLabel.font = [UIFont fontWithName:fontNewName size:12];
    hLabel.textColor = RGB_255(30, 130, 245);
    hLabel.text = [_newsInfo.hit stringByAppendingString:@"浏览"];
    hLabel.textAlignment = UITextAlignmentRight;
    [_sView addSubview:hLabel];

}

-(void) layoutSubviews{
    [super layoutSubviews];
    
}


@end
