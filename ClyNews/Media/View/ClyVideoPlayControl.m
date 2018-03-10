//
//  ClyVideoPlayControl.m
//  ClyNews
//
//  Created by 陈立宇 on 17/3/4.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyVideoPlayControl.h"

@interface ClyVideoPlayControl ()
//进度条
@property (nonatomic,strong) UISlider *progressSlider;
//全屏按钮
@property (nonatomic,strong) UIButton *largeSmallBtn;
//缓冲进度条
@property (nonatomic,strong) UIProgressView *bufferProgressView;

@end

static const CGFloat padding=10.f;

@implementation ClyVideoPlayControl


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void) setupUI{
    
    //缓冲进度条
    self.bufferProgressView=[[UIProgressView alloc]init];
    self.bufferProgressView.frame = CGRectMake(52, 40/2-0.5, kScreenWidth-50*2-40-2, 0.3);
    self.bufferProgressView.progressTintColor=[UIColor whiteColor];
    //self.bufferProgressView.progress = 1.0f;
    self.bufferProgressView.trackTintColor=[UIColor lightGrayColor];
    [self addSubview:self.bufferProgressView];
    
    //初始时间
    self.trackingTimeLabel=[self createLabel];
    self.trackingTimeLabel.frame = CGRectMake(0, 0, 50, 40);
    self.trackingTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    //最大时间
    self.totalTimeLabel=[self createLabel];
    self.totalTimeLabel.frame = CGRectMake(kScreenWidth-40-50, 0, 50, 40);
    self.totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    //进度条
    self.progressSlider=[[UISlider alloc]init];
    self.progressSlider.frame = CGRectMake(50, 0, kScreenWidth-50*2-40, 40);
    [self.progressSlider addTarget:self action:@selector(progressValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.progressSlider.minimumTrackTintColor=navigationBarColor;
    //[self.progressSlider setThumbImage:[UIImage imageNamed:@"Source.bundle/thumbNormal"] forState:UIControlStateNormal];
    [self.progressSlider setMaximumTrackTintColor:[UIColor clearColor]];
    self.progressSlider.value=0;
    [self addSubview:self.progressSlider];
    
    //全屏按钮
    self.largeSmallBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.largeSmallBtn.frame = CGRectMake(kScreenWidth-40, 0, 40, 40);
    [self.largeSmallBtn setImage:[UIImage imageNamed:@"play_on"] forState:UIControlStateNormal];
    [self.largeSmallBtn setImage:[UIImage imageNamed:@"play_down"] forState:UIControlStateHighlighted];
    [self.largeSmallBtn addTarget:self action:@selector(scallingChange:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.largeSmallBtn];

}

-(UILabel *)createLabel{
    UILabel *label=[[UILabel alloc]init];
    //label.frame = CGRectMake(0, 0, 70, 40);
    label.text=@"00:00";
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont fontWithName:fontNewName size:12];
    [self addSubview:label];
    return label;
}

-(void)progressValueChanged:(UISlider *)slider{
    if ([self.delegate respondsToSelector:@selector(sendCurrentValueToPlayer:)]) {
        [self.delegate sendCurrentValueToPlayer:self.progressSlider.value];
    }
}

-(void)scallingChange:(UIButton *)button{
    button.selected=!button.selected;
    if (button.selected) {
        self.scalling=ClyPlayerControlScallingLarge;
    }else{
        self.scalling=ClyPlayerControlScallingNormal;
    }
    
}

-(void)setMinValue:(CGFloat)minValue{
    self.progressSlider.minimumValue=minValue;
}
-(void)setMaxValue:(CGFloat)maxValue{
    self.progressSlider.maximumValue=maxValue;
}
-(void)setCurrentValue:(CGFloat)currentValue{
    self.progressSlider.value=currentValue;
}
-(void)setBufferValue:(CGFloat)bufferValue{
    self.bufferProgressView.progress=bufferValue;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
