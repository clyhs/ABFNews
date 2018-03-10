//
//  ClyNewsCommentViewCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/12.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyNewsCommentViewCell.h"
#import "ClyUser.h"
#import "ClyCommentReply.h"

@interface ClyNewsCommentViewCell()

@property(nonatomic,weak) UIView *topView;
@property(nonatomic,weak) UIView *bottomView;

@end

@implementation ClyNewsCommentViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCommentInfo:(ClyCommentInfo *)commentInfo{
    _commentInfo = commentInfo;
    
    self.backgroundColor = tableWhiteColor;
    
    [self addTopView];
    [self addImageNode];
    [self addUserLabel];
    [self addAreaLabel];
    [self addContentLabel];
    
    [self addBottomView];
    [self addReplyLabels];
    [self addLineView];
    
}

-(void) addTopView{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50+_commentInfo.contentHeight)];
    [self addSubview:topView];
    _topView = topView;
    
}

-(void) addBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(50, 50+_commentInfo.contentHeight, kScreenWidth-50-20, _commentInfo.replyHeight+10)];
    bottomView.layer.borderColor = replyCellColor.CGColor;
    bottomView.layer.borderWidth = 0.5;
    /*
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    borderLayer.path = [UIBezierPath bezierPathWithRect:bottomView.bounds].CGPath;
    borderLayer.lineWidth = 0.3f;
    borderLayer.lineCap = @"square";
    borderLayer.lineDashPattern = @[@4, @4];
    [bottomView.layer addSublayer:borderLayer];
    //bottomView.layer.*/
    bottomView.backgroundColor = replyCellColor;
    [self addSubview:bottomView];
    _bottomView = bottomView;
}


-(void) addImageNode{
    
    UIImageView *userImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    userImg.layer.masksToBounds = YES;
    userImg.layer.cornerRadius = userImg.bounds.size.width*0.5;
    userImg.layer.borderWidth = 2.0;
    userImg.layer.borderColor = [UIColor whiteColor].CGColor;
    [userImg sd_setImageWithURL:_commentInfo.user.img placeholderImage:[UIImage imageNamed:@""]];
    [_topView addSubview:userImg];

}

-(void) addUserLabel{
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, kScreenWidth, 18)];
    userLabel.font = [UIFont fontWithName:fontNewName size:14];
    userLabel.text = _commentInfo.user.username;
    userLabel.textColor = fontHightlightColor;
    [_topView addSubview:userLabel];
    
}



-(void) addAreaLabel{
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, kScreenWidth, 18)];
    aLabel.font = [UIFont fontWithName:fontNewName size:12];
    NSString *str = @"中国  ";
    aLabel.text =[str stringByAppendingString:_commentInfo.createTime];
    aLabel.textColor = [UIColor lightGrayColor];
    [_topView addSubview:aLabel];
}

-(void) addContentLabel{

    CGFloat labelWidth = kScreenWidth-50-20;
    UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, labelWidth, _commentInfo.contentHeight)];
    cLabel.font = [UIFont fontWithName:fontNewName size:13];
    cLabel.textColor = [UIColor grayColor];
    //cLabel.text = _commentInfo.content;
    cLabel.numberOfLines = 0;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:_commentInfo.content];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = 0;//缩进
    style.firstLineHeadIndent = 0;
    style.lineSpacing = 6;//行距
    
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    cLabel.attributedText = text;

    
    [_topView addSubview:cLabel];
}

-(void) addReplyLabels{

    CGFloat labelWidth = kScreenWidth-50-20;
    NSInteger replyCount = _commentInfo.replys.count;
    NSArray *replys = [ClyCommentReply mj_objectArrayWithKeyValuesArray:_commentInfo.replys];
    CGFloat nHeight = 0;
    for(NSInteger i=0;i<replyCount;i++){
        ClyCommentReply *reply = replys[i];
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*i, labelWidth, 20)];
        NSString *str = [reply.username stringByAppendingString:@":"];
        content.text =[str stringByAppendingString:reply.replyContent] ;
        //content.text = reply.replyContent;
        content.font = [UIFont fontWithName:fontNewName size:13];
        content.numberOfLines = 0;
        content.textColor = [UIColor lightGrayColor];
        
        CGFloat height = [UILabel getHeightByWidth:labelWidth title:content.text font:content.font];
        
        content.frame = CGRectMake(5, 20*i+6, labelWidth, height+6);

        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[str stringByAppendingString:reply.replyContent]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.headIndent = 0;//缩进
        style.firstLineHeadIndent = 0;
        style.lineSpacing = 6;//行距
        
        [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
        NSInteger usernameCount = reply.username.length;
        [text addAttribute:NSForegroundColorAttributeName value:fontHightlightColor range:NSMakeRange(0, usernameCount)];
        content.attributedText = text;
        //content.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //content.layer.borderWidth = 1.0;
        [_bottomView addSubview:content];
    }
}

-(void) addLineView{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 55+_commentInfo.contentHeight+_commentInfo.replyHeight+9+20, kScreenWidth, 1)];
    lineView.backgroundColor = lineColor;
    [_topView addSubview:lineView];
}

@end
