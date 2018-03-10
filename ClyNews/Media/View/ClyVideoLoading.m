//
//  ClyVideoLoading.m
//  ClyNews
//
//  Created by 陈立宇 on 17/3/5.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyVideoLoading.h"

//间隔时间
#define duration 1.0f
//加载图片名
#define kLoadingImageName @"play_loading"

@interface ClyVideoLoading(){
    NSTimer *_timer;//定时器
}
@property (nonatomic,strong) UIImageView *loadingImage;//加载时的图片
@end

@implementation ClyVideoLoading

//初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.loadingImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:kLoadingImageName]];
        self.loadingImage.contentMode=UIViewContentModeScaleAspectFill;
        self.loadingImage.frame = CGRectMake(kScreenWidth/2 - 15, kVideoPlayHeight/2-15,30 , 30);
        [self addSubview:self.loadingImage];
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    return self;
}

//显示
-(void)show{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer=nil;
    }
    self.hidden=NO;
    _timer=[NSTimer timerWithTimeInterval:duration/2 target:self selector:@selector(rotationImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
}
//旋转图片
-(void)rotationImage{
    
    [UIView animateWithDuration:duration animations:^{
        self.loadingImage.transform=CGAffineTransformRotate(self.loadingImage.transform, M_PI);
    }];
}
//隐藏
-(void)hide{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer=nil;
    }
    self.hidden=YES;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
