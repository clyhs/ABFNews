//
//  ClyPlayer.m
//  ClyNews
//
//  Created by 陈立宇 on 17/3/5.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyPlayer.h"

@interface ClyPlayer()<ClyVideoPlayPausedViewDelegate,ClyPlayerControlSliderDelegate>

{
    NSURL *_url;
    NSTimer *_timer;
    
}
@property (nonatomic,strong) AVPlayerLayer *playerLayer;
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerItem *item;
//总时长
@property (nonatomic,assign) CGFloat totalDuration;
//转换后的时间
@property (nonatomic,copy) NSString *totalTime;
//当前播放位置
@property (nonatomic,assign) CMTime currenTime;
//监听播放值
@property (nonatomic,strong) id playbackTimerObserver;

@property (nonatomic,strong) id playBufferTimeObserver;
//全屏控制器
@property (nonatomic,strong) UIViewController *fullVC;
//全屏播放器
@property (nonatomic,strong) ClyPlayer *fullScreenPlayer;

@property (strong, nonatomic) UISlider *volume;


@end

@implementation ClyPlayer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithUrl: (NSURL *)url
{
    self = [super init];
    if (self) {
        _url=url;
        [self initAsset];
        [self setupPlayer];
    }
    return self;
}
- (instancetype)initWithURLAsset:(AVURLAsset *)asset{
    self=[super init];
    if (self) {
        self.assert=asset;
        [self setupPlayer];
        
    }
    return self;
}

+(Class)layerClass{
    return [AVPlayerLayer class];
}

-(void)initAsset{
    if (_url) {
        self.assert=[[AVURLAsset alloc]initWithURL:_url options:nil];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame=self.bounds;
    self.playerControl.frame = CGRectMake(0, self.bounds.size.height-40, kScreenWidth, 40);
    _playPausedView.frame = CGRectMake(0, 0, kScreenWidth, self.bounds.size.height);
}

-(void) setupPlayer{
    [self configPlayer];
    [self addPlayPausedView];
    [self addPlayerControl];
    //[self addVolumeControl];
    [self addPlayerLoading];
    [self addGesture];
    [self addKVO];
    [self addNotification];
}

//配置播放器
-(void)configPlayer{
    self.backgroundColor=[UIColor blackColor];
    self.item=[AVPlayerItem playerItemWithAsset:self.assert];
    self.player=[[AVPlayer alloc]init];
    [self.player replaceCurrentItemWithPlayerItem:self.item];
    self.player.usesExternalPlaybackWhileExternalScreenIsActive=YES;
    self.playerLayer=[[AVPlayerLayer alloc]init];
    self.playerLayer.backgroundColor=[UIColor blackColor].CGColor;
    self.playerLayer.player=self.player;
    self.playerLayer.frame=self.bounds;
    [self.playerLayer displayIfNeeded];
    [self.layer insertSublayer:self.playerLayer atIndex:0];
    self.playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;
}

-(void)addPlayPausedView{
    NSLog(@"addPlayPausedView");
    self.playPausedView =[[ClyVideoPlayPauseView alloc] init];
    
    _playPausedView.delegate=self;
    [self addSubview:_playPausedView];
    self.playPausedView.state=ClyControlStateNormal;
    [self.playPausedView show];
}

#pragma mark - addPlayerControl
//添加播放控制器
-(void)addPlayerControl{
    self.playerControl=[[ClyVideoPlayControl alloc]init];
    self.playerControl.minValue=0.0f;
    self.playerControl.delegate=self;
    //设置播放控制器的背景颜色
    self.playerControl.backgroundColor=[UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:0.5];
    NSLog(@"self.totalDuration:%f",self.totalDuration);
    [self addSubview:self.playerControl];
    NSLog(@"***************%lf",self.frame.size.height);
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.playerControl.hidden=YES;
}

//添加加载视图
-(void)addPlayerLoading{
    self.loadingView=[[ClyVideoLoading alloc] init];
    self.loadingView.frame = CGRectMake(0, 0, kScreenWidth, kVideoPlayHeight);
    self.loadingView.hidden=YES;
    [self addSubview:self.loadingView];
}

-(void)addVolumeControl{
    self.volume = [[UISlider alloc] init];
    self.volume.value =5.0f;
    //设置最大值最小值音量
    self.volume.maximumValue =10.0f;
    self.volume.minimumValue =0.0f;
    self.volume.frame = CGRectMake(kScreenWidth-40, 15, 30, kVideoPlayHeight-15*2);
    self.volume.minimumTrackTintColor=navigationBarColor;
    [self.volume setMaximumTrackTintColor:[UIColor clearColor]];
    [self addSubview:self.volume];
    
}

-(void) testClick{
    NSLog(@"test");
}

-(void)sendPlayOrPausedValueToPlayer{
    NSLog(@"send");
    [self hideOrShowPauseView];
}

-(void)sendCurrentValueToPlayer:(CGFloat)value{
    //获取进度条所在位置值的时间
    self.currenTime=CMTimeMake(value*self.item.duration.timescale, self.item.duration.timescale);
    [self.player seekToTime:self.currenTime];
}

//显示或者隐藏暂停按键
-(void)hideOrShowPauseView{
    NSLog(@"hideOrShowPauseView");
    if (!_isNormal) {
        self.playPausedView.state=ClyControlStateNormal;
        [self.playPausedView hide];
        [self.player play];
    }else{
        self.playPausedView.state=ClyControlStateSelected;
        [self.playPausedView show];
        [self.player pause];
    }
    self.playerControl.hidden=NO;
    if (kScreenWidth<kScreenHeight){
        self.playPausedView.backBtn.hidden=YES;
    }else{
        self.playPausedView.backBtn.hidden=NO;
    }
    self.playPausedView.title.hidden=NO;
    [self addPlayerControlTimer];
    _isNormal=!_isNormal;
}
-(void)addPlayerControlTimer{
    if (_timer) {
        return;
    }
    _timer=[NSTimer scheduledTimerWithTimeInterval:5.f repeats:NO block:^(NSTimer * _Nonnull timer) {
        if (![self.playerControl isHidden]) {
            self.playerControl.hidden=YES;
            _timer=nil;
        }
    }];
}

//添加手势
-(void)addGesture{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

//点击播放器手势事件
-(void)tapAction:(UITapGestureRecognizer *)gesture{
    NSLog(@"tapAction");
    if ([self.playerControl isHidden]) {
        self.playerControl.hidden=NO;
        [self addPlayerControlTimer];
    }else{
        [self hideOrShowPauseView];
    }
}
-(void)addKVO{
    //监听状态属性
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监听网络加载情况属性
    [self.item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //监听播放的区域缓存是否为空
    [self.item addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    //缓存可以播放的时候调用
    [self.item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    //监听暂停或者播放中
    [self.player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
    [self.player addObserver:self forKeyPath:@"timeControlStatus" options:NSKeyValueObservingOptionNew context:nil];
    [self.playerControl addObserver:self forKeyPath:@"scalling" options:NSKeyValueObservingOptionNew context:nil];
    [self.playPausedView addObserver:self forKeyPath:@"backBtnTouched" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)addNotification{
    //监听当视频播放结束时
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ClyPlayerItemDidPlayToEndTimeNotification:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
    //监听当视频开始或快进或者慢进或者跳过某段播放
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ClyPlayerItemTimeJumpedNotification:) name:AVPlayerItemTimeJumpedNotification object:[self.player currentItem]];
    //监听播放失败时
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ClyPlayerItemFailedToPlayToEndTimeNotification:) name:AVPlayerItemFailedToPlayToEndTimeNotification object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ClyPlayerItemPlaybackStalledNotification:) name:AVPlayerItemPlaybackStalledNotification object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ClyPlayerItemNewAccessLogEntryNotification:) name:AVPlayerItemNewAccessLogEntryNotification object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ClyPlayerItemNewErrorLogEntryNotification:) name:AVPlayerItemNewErrorLogEntryNotification object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ClyPlayerItemFailedToPlayToEndTimeErrorKey:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)ClyPlayerItemDidPlayToEndTimeNotification:(NSNotification *)notification{
    NSLog(@"%s",__FUNCTION__);
    [self.item seekToTime:kCMTimeZero];
    [self.player pause];
    _isNormal=0;
    [self addPlayPausedView];
    
}
-(void)ClyPlayerItemTimeJumpedNotification:(NSNotification *)notification{
    NSLog(@"%s",__FUNCTION__);
}
-(void)ClyPlayerItemFailedToPlayToEndTimeNotification:(NSNotification *)notification{
    NSLog(@"%s",__FUNCTION__);
}
-(void)ClyPlayerItemPlaybackStalledNotification:(NSNotification *)notification{
    NSLog(@"%s",__FUNCTION__);
}
-(void)ClyPlayerItemNewAccessLogEntryNotification:(NSNotification *)notification{
    NSLog(@"%s",__FUNCTION__);
}
-(void)ClyPlayerItemNewErrorLogEntryNotification:(NSNotification *)notification{
    NSLog(@"%s",__FUNCTION__);
}
-(void)ClyPlayerItemFailedToPlayToEndTimeErrorKey:(NSNotification *)notification{
    NSLog(@"%s",__FUNCTION__);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status=[[change objectForKey:NSKeyValueChangeNewKey]integerValue];
        switch (status) {
            case AVPlayerStatusUnknown:{
                NSLog(@"未知状态");
                self.state=ClyPlayerStateBuffering;
            }
                break;
            case AVPlayerStatusReadyToPlay:{
                NSLog(@"开始播放状态");
                self.state=ClyPlayerStatePlaying;
                //总时长
                self.totalDuration=self.item.duration.value/self.item.duration.timescale;
                //转换成时间格式的总时长
                self.totalTime=[self convertTime:self.totalDuration];
                //总时间
                self.playerControl.totalTimeLabel.text=self.totalTime;
                self.playPausedView.totalTime.text=self.totalTime;
                //设置播放控制器进度最大值和最小值
                self.playerControl.minValue=0;
                self.playerControl.maxValue=self.totalDuration;
                [self addTimer];
                
                if (self.loadingView) {
                    [self.loadingView hide];
                    [self.loadingView removeFromSuperview];
                }
            }
                break;
            case AVPlayerStatusFailed:
                self.state=ClyPlayerStateFailed;
                
                NSLog(@"播放失败");
                break;
            
            default:
                break;
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {  //监听播放器的下载进度
        
        NSArray *loadedTimeRanges = [self.item loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
        CMTime duration = self.item.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        //缓存值
        NSLog(@"下载进度：%.2f", timeInterval / totalDuration);
        self.playerControl.bufferValue=timeInterval / totalDuration;
        [self addBuffer];
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) { //监听播放器在缓冲数据的状态
        self.state=ClyPlayerStateBuffering;
        NSLog(@"缓冲不足暂停");
    } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        NSLog(@"缓冲达到可播放");
    } else if ([keyPath isEqualToString:@"rate"]){//当rate==0时为暂停,rate==1时为播放,当rate等于负数时为回放
        if ([[change objectForKey:NSKeyValueChangeNewKey]integerValue]==0) {
            _isPlaying=false;
        }else{
            _isPlaying=true;
        }
    } else if ([keyPath isEqualToString:@"timeControlStatus"]){
        //timeControlStatus==0是暂停,==1时播放
        NSLog(@"timeControlStatus:%@",[change objectForKey:NSKeyValueChangeNewKey]);
        if ([[change objectForKey:NSKeyValueChangeNewKey]integerValue]==1) {
            [self.loadingView show];
        }else{
            [self.loadingView hide];
        }
    }else if ([keyPath isEqualToString:@"scalling"]){
        //全屏或者小屏
        if (kScreenWidth<kScreenHeight) {
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
            self.playPausedView.title.hidden=NO;
        }else{
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
        }
        
    }else if ([keyPath isEqualToString:@"backBtnTouched"]){
        [self interfaceOrientation:UIInterfaceOrientationPortrait];
    }
}


//将数值转换成时间
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}

//监听视频播放时间
-(void)addTimer{
    //设置间隔时间
    CMTime interval=CMTimeMake(1.f, 1.f);
    __weak typeof(self) weakSelf=self;
    self.playbackTimerObserver=[weakSelf.player addPeriodicTimeObserverForInterval:interval queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //使进度条跟着视频播放前进
        CGFloat currentValue=self.item.currentTime.value/self.item.currentTime.timescale;
        self.playerControl.currentValue=currentValue;
        self.playerControl.trackingTimeLabel.text=[self convertTime:currentValue];
        NSLog(@"%f",currentValue);
    }];
}

-(void)addBuffer{
    CMTime interval=CMTimeMake(1.f, 1.f);
    __weak typeof(self) weakSelf=self;
    self.playBufferTimeObserver = [weakSelf.player addPeriodicTimeObserverForInterval:interval queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
    
        NSArray *loadedTimeRanges = [self.item loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
        CMTime duration = self.item.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        
        self.playerControl.bufferValue=timeInterval / totalDuration;
        
        
    }];
}

//获取当前时间
-(CMTime)currentTime{
    return self.item.currentTime;
}

-(void)setNeedsDisplay{
    NSLog(@"%s",__FUNCTION__);
    
}

-(void)seekToTime:(CMTime)time{
    [self.item seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}
-(void)play{
    if (self.player!=nil ) {
        [self.playerLayer isReadyForDisplay];
        [self.player play];
    }
}
-(void)pause{
    if (self.player!=nil ) {
        [self.player pause];
    }
}
-(void)stop{
    [self.item seekToTime:kCMTimeZero];
    [self.player pause];
    _isNormal=0;
    [self addPlayPausedView];
}


//设置视频填充模式
-(void)setContentMode:(ClyPlayerContentMode)contentMode{
    switch (contentMode) {
        case ClyPlayerContentModeResizeFit:
            self.playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;
            break;
        case ClyPlayerContentModeResizeFitFill:
            self.playerLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;
            break;
        case ClyPlayerContentModeResize:
            self.playerLayer.videoGravity=AVLayerVideoGravityResize;
            break;
    }
}

- (void)deviceOrientationDidChange: (NSNotification *)notification
{
    UIInterfaceOrientation _interfaceOrientation=[[UIApplication sharedApplication]statusBarOrientation];
    switch (_interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            self.fullVC=[self pushToFullScreen];
            [self.player pause];
            [self.fullScreenPlayer seekToTime:self.item.currentTime];
            
            [[self activityViewController] presentViewController:self.fullVC animated:NO completion:nil];
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        case UIInterfaceOrientationPortrait:
        {
            
            if (self.fullVC) {
                if (self.fullScreenPlayer.isPlaying) {
                    [self.player play];
                    [self.playPausedView hide];
                }else{
                    [self pause];
                    _isNormal=1;
                    [self hideOrShowPauseView];
                }
                if (self.fullScreenPlayer.item.currentTime.value/self.fullScreenPlayer.item.currentTime.timescale>0) {
                    [self.player seekToTime:self.fullScreenPlayer.currentTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
                }
                [self.fullScreenPlayer remove];
                self.fullScreenPlayer=nil;
                [self.fullVC dismissViewControllerAnimated:NO completion:nil];
            }
        }
            break;
        case UIInterfaceOrientationUnknown:
            NSLog(@"UIInterfaceOrientationLandscapePortial");
            break;
    }
}

//推入全屏
-(UIViewController *)pushToFullScreen{
    UIViewController *vc=[[UIViewController alloc]init];
    [[self getCurrentVC] prefersStatusBarHidden];
    self.fullScreenPlayer=[[ClyPlayer alloc]initWithURLAsset:self.assert];
    [vc.view addSubview:self.fullScreenPlayer];
    self.fullScreenPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    if (_isPlaying) {
        [self.fullScreenPlayer play];
        [self.fullScreenPlayer.playPausedView hide];
    }else{
        [self.fullScreenPlayer pause];
    }
    //[self.fullScreenPlayer setTitle:self.playPausedView.title.text];
    return vc;
    
}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

- (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}

//旋转方向
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    if (orientation == UIInterfaceOrientationLandscapeRight||orientation == UIInterfaceOrientationLandscapeLeft) {
        // 设置横屏
    } else if (orientation == UIInterfaceOrientationPortrait) {
        // 设置竖屏
    }
}

-(void)remove{
    [self.item removeObserver:self forKeyPath:@"status"];
    [self.item removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.item removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.item removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.player removeObserver:self forKeyPath:@"rate"];
    [self.player removeObserver:self forKeyPath:@"timeControlStatus"];
    [self.playerControl removeObserver:self forKeyPath:@"scalling"];
    [self.player removeTimeObserver:self.playbackTimerObserver];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemTimeJumpedNotification object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemTimeJumpedNotification object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeNotification object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemNewAccessLogEntryNotification object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemNewErrorLogEntryNotification object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [self.item seekToTime:kCMTimeZero];
    self.assert=nil;
    [self.player setRate:0];
    [self.player pause];
    self.item=nil;
    [self.player replaceCurrentItemWithPlayerItem:nil];
    self.playerLayer.player=nil;
    self.totalDuration=0;
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    [self.playerLayer removeFromSuperlayer];
    [self removeFromSuperview];
}
-(void)dealloc{
    [self remove];
}



@end
