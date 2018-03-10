//
//  ClyVideoPlayPauseView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/3/5.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyVideoPlayPauseView.h"

@implementation ClyVideoPlayPauseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    _playPauseBtn.frame = CGRectMake(kScreenWidth/2-27, self.bounds.size.height/2-27, 54, 54);
}

-(void) setupUI{
    
    UIButton *playPauseBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    //playPauseBtn.frame = CGRectMake(0, 0, kScreenWidth, kVideoPlayHeight);
    playPauseBtn.contentMode=UIViewContentModeScaleToFill;
    [playPauseBtn addTarget:self action:@selector(pauseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    //self.playPauseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //self.playPauseBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    playPauseBtn.contentMode=UIViewContentModeScaleToFill;
    //[playPauseBtn addTarget:self action:@selector(pauseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:playPauseBtn];
    _playPauseBtn = playPauseBtn;
    self.hidden=YES;
    
    //添加返回Button
    self.backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 0, 40, 40);
    [self.backBtn setImage:[UIImage imageNamed:@"back_video"] forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:@"back_video_highlight"] forState:UIControlStateHighlighted];
    [self.backBtn addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backBtn];

}



-(void)buttonTouched:(UIButton *)button{
    self.backBtnTouched=1;
    if ([self.delegate respondsToSelector:@selector(testClick)]) {
        [self.delegate testClick];
    }
    
}

-(void)pauseBtnClicked:(UIButton *)button{
    NSLog(@"pauseBtnClicked");
    if ([self.delegate respondsToSelector:@selector(sendPlayOrPausedValueToPlayer)]) {
        [self.delegate sendPlayOrPausedValueToPlayer];
    }
}

-(void)setState:(ClyPlayerControlState)state
{
    switch (state) {
        case ClyControlStateNormal:{
            self.playPauseBtn.selected=NO;
            [self.playPauseBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
            [self.playPauseBtn setImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
            //self.totalTime.hidden=NO;
            //self.title.hidden=NO;
            self.backBtn.hidden=YES;
        }
            break;
        case ClyControlStateSelected:{
            self.playPauseBtn.selected=YES;
            [self.playPauseBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.playPauseBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
            //self.totalTime.hidden=YES;
            //self.title.hidden=NO;
        }
            break;
    }
}

-(void)show{
    self.hidden=NO;
}
-(void)hide{
    self.hidden=YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
