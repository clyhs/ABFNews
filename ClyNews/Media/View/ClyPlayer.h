//
//  ClyPlayer.h
//  ClyNews
//
//  Created by 陈立宇 on 17/3/5.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyVideoPlayPauseView.h"
#import "ClyVideoLoading.h"
#import <AVFoundation/AVFoundation.h>
#import "ClyVideoPlayControl.h"


/**
 设置视频播放填充模式
 */
typedef NS_ENUM(NSInteger,ClyPlayerContentMode) {
    ClyPlayerContentModeResizeFit,//尺寸适合
    ClyPlayerContentModeResizeFitFill,//填充视图
    ClyPlayerContentModeResize,//默认
};
typedef NS_ENUM(NSInteger,ClyPlayerState) {
    ClyPlayerStateFailed,        // 播放失败
    ClyPlayerStateBuffering,     // 缓冲中
    ClyPlayerStatePlaying,       // 播放中
    ClyPlayerStateStopped,        //停止播放
};

@interface ClyPlayer : UIView

//当视频没有播放为0,播放后是1
@property (nonatomic,assign) NSInteger isNormal;
//加载的image;
@property (nonatomic,strong) UIImageView *imageViewLogin;
//视频填充模式
@property (nonatomic,assign) ClyPlayerContentMode contentMode;
//播放状态
@property (nonatomic,assign) ClyPlayerState state;
//加载视图
@property (nonatomic,strong) ClyVideoLoading *loadingView;
//是否正在播放
@property (nonatomic,assign,readonly) BOOL isPlaying;
//暂停时的插图
@property (nonatomic,strong) ClyVideoPlayPauseView *playPausedView;
//urlAsset
@property (nonatomic,strong) AVURLAsset *assert;
//当前时间
@property (nonatomic,assign) CMTime currentTime;
//播放器控制视图
@property (nonatomic,strong) ClyVideoPlayControl *playerControl;




//初始化
- (instancetype)initWithUrl:(NSURL *)url;
- (instancetype)initWithURLAsset:(AVURLAsset *)asset;
//设置标题
-(void)setTitle:(NSString *)title;
//跳到某个播放时间段
-(void)seekToTime:(CMTime)time;
//播放
-(void)play;
//暂停
-(void)pause;
//停止
-(void)stop;
//移除监听,notification,dealloc
-(void)remove;
//显示或者隐藏暂停按键
-(void)hideOrShowPauseView;
@end
