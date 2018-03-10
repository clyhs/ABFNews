//
//  ClyNewsImageViewCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/13.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyNewsImageViewCell.h"

@interface ClyNewsImageViewCell()

@property(nonatomic,weak) UIView *sView;

@end

static NSInteger newsMargin = 10;
static NSInteger newsImgHeight = 70;
static NSInteger newsImgWidth  = 80;
static NSInteger newsTimeAndHitHeight = 18;


@implementation ClyNewsImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setNewsInfo:(ClyNewsInfo *)newsInfo{
    
    _newsInfo = newsInfo;
    self.backgroundColor = tableWhiteColor;
    
    [self addSView];
    [self addImageView];
    [self addTitleLabel];
    [self addTimeAndHit];

}

-(void) addSView{
    
    CGFloat viewHeight = 2*newsMargin+newsImgHeight;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, viewHeight)];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight-0.2, kScreenWidth, 0.8)];
    lineView.backgroundColor = lineColor;
    [view addSubview:lineView];
    [self addSubview:view];
    _sView = view;

}

-(void) addImageView{

    UIImageView *newsImg = [[UIImageView alloc] initWithFrame:CGRectMake(newsMargin, newsMargin, newsImgWidth, newsImgHeight) ];
    newsImg.layer.cornerRadius = 2.0f;
    [newsImg sd_setImageWithURL:[NSURL URLWithString:self.newsInfo.images] placeholderImage:[UIImage imageNamed:@"newsIcon"]];
    [_sView addSubview:newsImg];
}

-(void) addTitleLabel{
    CGFloat height = 0;
    NSInteger count = _newsInfo.titleImgCellHeight - 44;
    if(count > 0){
        height= 44;
    }else{
        height=_newsInfo.titleImgCellHeight;
    }
    
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*newsMargin+newsImgWidth, newsMargin, kScreenWidth-newsMargin*3-newsImgWidth, height)];
    tLabel.font = [UIFont fontWithName:fontNewName size:16];
    tLabel.text = _newsInfo.title;
    
    
    tLabel.numberOfLines = 0;
    
    tLabel.textColor =fontColor;
    [_sView addSubview:tLabel];
}

-(void) addTimeAndHit{
    
    
    UILabel *sLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*newsMargin+newsImgWidth,newsMargin+newsImgHeight-18, 80, 18)];
    sLabel.font = [UIFont fontWithName:fontNewName size:12];
    sLabel.textColor = RGB_255(30, 130, 245);
    sLabel.text = _newsInfo.createTime;
    [_sView addSubview:sLabel];
    
    UILabel *hLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-newsMargin-50, newsMargin+newsImgHeight-18, 50, 18)];
    hLabel.font = [UIFont fontWithName:fontNewName size:12];
    hLabel.textColor = RGB_255(30, 130, 245);
    hLabel.text = [_newsInfo.hit stringByAppendingString:@"浏览"];
    hLabel.textAlignment = UITextAlignmentRight;
    [_sView addSubview:hLabel];
}

@end
