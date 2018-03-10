//
//  ClyVideoSimpleViewCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/13.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyVideoSimpleViewCell.h"

@interface ClyVideoSimpleViewCell()<VideoPlayViewDelegate>





@end

@implementation ClyVideoSimpleViewCell

+(instancetype)cell {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setVideoInfo:(ClyVideoInfo *)videoInfo hidden:(Boolean) flag {
    
    _videoInfo = videoInfo;
    _bottomHidden = flag;
    [self addVideoImg];
    [self addBgView];
    [self addPlayButton];
    [self addVideoTitle];
    [self addTimeLabel];
    
    if(!_bottomHidden){
        [self addBottomViewButton];
        [self addImageNode];
        [self addUserLabel];
        NSLog(@"%@",@"1");
    }else{
        //[self addDownloadBtn];
        // NSLog(@"%@",@"2");
    }
    
    
}

-(void) addVideoImg{
    
    //[self.videoImg sd_setImageWithURL:[NSURL URLWithString:self.videoInfo.img] placeholderImage:[UIImage imageNamed:@"head portrait"] options:nil];
    //[self.videoImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"loading_bgView"]];
    [self.videoImg setImage:[UIImage imageNamed:@"loading_bgView"]];
    NSLog(@"video.img=%@",self.videoInfo.img);
    self.videoImg.tag = 101;
    //self.videoImg.hidden = YES;

}

-(void) addBgView{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, kScreenWidth, kVideoPlayHeight);
    //3. 背景颜色可以用多种方法看需要咯
    bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    [self addSubview:bgView];
    _bgView = bgView;
}

-(void) addPlayButton{
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(kScreenWidth/2 - 63/2, 180/2-63/2, 63, 63);
    [playBtn setImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(onPlayClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:playBtn];
    _playBtn = playBtn;

}

-(void) addVideoTitle{
    
    UILabel *videoTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 28)];
    videoTitle.font = [UIFont fontWithName:fontNewName size:18];
    videoTitle.text = _videoInfo.name;
    videoTitle.numberOfLines = 0;
    videoTitle.textColor = [UIColor whiteColor];
    [_bgView addSubview:videoTitle];
}

-(void) addDownloadBtn{
    
    UILabel  *downloadLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 150, 30)];
    downloadLabel.textColor = fontColor;
    downloadLabel.font = [UIFont fontWithName:fontNewName size:14];
    downloadLabel.text = @"";
    [_bottomView addSubview: downloadLabel];
    _downloadLabel = downloadLabel;
    
    UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadBtn.frame = CGRectMake(kScreenWidth-40, 15, 30, 30);
    [downloadBtn setImage:[UIImage imageNamed:@"icon_download2"] forState:UIControlStateNormal];
    [downloadBtn addTarget:self action:@selector(onDownloadClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview: downloadBtn];
    _downloadBtn = downloadBtn;
}

-(void) addTimeLabel{
    
    UILabel *sLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-90,180-20, 80, 18)];
    sLabel.font = [UIFont fontWithName:fontNewName size:12];
    sLabel.textColor = RGB_255(30, 130, 245);
    sLabel.text = _videoInfo.videoTime;
    sLabel.textColor = [UIColor whiteColor];
    sLabel.textAlignment = UITextAlignmentRight;
    [_bgView addSubview:sLabel];

}

-(void) addImageNode{
    
    UIImageView *userImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 36, 36)];
    userImg.layer.masksToBounds = YES;
    userImg.layer.cornerRadius = userImg.bounds.size.width*0.5;
    userImg.layer.borderWidth = 2.0;
    userImg.layer.borderColor = [UIColor whiteColor].CGColor;
    [userImg sd_setImageWithURL:@"http://www.comke.net/public/upload/user/img2011-12-1616-11-19.jpg" placeholderImage:[UIImage imageNamed:@""]];
    [_bottomView addSubview:userImg];
    
}

-(void) addUserLabel{
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, _bottomView.frame.size.height/2-12, kScreenWidth, 18)];
    userLabel.font = [UIFont fontWithName:fontNewName size:14];
    userLabel.text = @"admin";
    userLabel.textColor = fontHightlightColor;
    [_bottomView addSubview:userLabel];
    
}

-(void) addBottomViewButton{
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(kScreenWidth-140, 54/2-20, 40, 40);
    [commentBtn setImage:[UIImage imageNamed:@"icon_comment"] forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [commentBtn addTarget:self action:@selector(onCommentClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:commentBtn];
    
    UIButton *dingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dingBtn.frame = CGRectMake(kScreenWidth-95, 52/2-19, 38, 38);
    [dingBtn setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
    [dingBtn addTarget:self action:@selector(onDingClick:) forControlEvents:UIControlEventTouchUpInside];
    [dingBtn setImage:[UIImage imageNamed:@"icon_highlight_like"] forState:UIControlStateSelected];
    [_bottomView addSubview:dingBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(kScreenWidth-50, 52/2-19, 38, 38);
    [shareBtn setImage:[UIImage imageNamed:@"icon_grayshare"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"icon_highlight_share"] forState:UIControlStateSelected];
    [shareBtn addTarget:self action:@selector(onShareClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:shareBtn];
    
    
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _bottomView.frame.size.height-8, kScreenWidth, 8)];
    lineView.backgroundColor = RGB_255(245, 245, 245);
    
    UIView *grayLineView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 0.3)];
    grayLineView.backgroundColor = RGB_255(220, 220, 220);
    [lineView addSubview:grayLineView];
    [_bottomView addSubview:lineView];

}

-(void) onPlayClick:(UIButton *)sender{
    NSLog(@"play...");
    /*
    if ([self.delegate respondsToSelector:@selector(clickVideoButton:)]) {
        [self.delegate clickVideoButton:self.indexPath];
    }*/
    if (self.playBlock) {
        self.playBlock(sender);
    }
}

-(void) onCommentClick:(id)sender{
    NSLog(@"comment...");
    if ([self.delegate respondsToSelector:@selector(clickCommentButton:)]) {
        [self.delegate clickCommentButton:self.indexPath];
    }
}

-(void) onDownloadClick:(id)sender{
    NSLog(@"download...");
    if ([self.delegate respondsToSelector:@selector(clickDownloadButton)]) {
        [self.delegate clickDownloadButton];
    }
}

-(void) onDingClick:(id)sender{
    NSLog(@"ding...");
    UIButton *dingBtn = (UIButton *)sender;
    dingBtn.selected = !dingBtn.selected;
}

-(void) onShareClick:(id)sender{
    NSLog(@"share...");
    UIButton *sBtn = (UIButton *)sender;
    sBtn.selected = !sBtn.selected;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    //self.videoImg.frame = CGRectMake(0, 0, kScreenWidth, 180);
}

@end
