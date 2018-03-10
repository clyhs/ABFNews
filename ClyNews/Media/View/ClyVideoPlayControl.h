//
//  ClyVideoPlayControl.h
//  ClyNews
//
//  Created by 陈立宇 on 17/3/4.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClyPlayerControlSliderDelegate<NSObject>
//发送进度条当前值
-(void)sendCurrentValueToPlayer:(CGFloat)value;

@end

typedef NS_ENUM(NSInteger,ClyPlayerControlScalling) {
    ClyPlayerControlScallingNormal,
    ClyPlayerControlScallingLarge,//全屏
};

@interface ClyVideoPlayControl : UIView

//进度条最小值
@property (nonatomic,assign) CGFloat minValue;
//进度条最大值
@property (nonatomic,assign) CGFloat maxValue;
//当前值
@property (nonatomic,assign) CGFloat currentValue;
//缓冲值
@property (nonatomic,assign) CGFloat bufferValue;
//当前播放时间
@property (nonatomic,strong) UILabel *trackingTimeLabel;
//最大时间Label
@property (nonatomic,strong) UILabel *totalTimeLabel;

@property (nonatomic,assign) ClyPlayerControlScalling scalling;

@property (nonatomic,weak) id<ClyPlayerControlSliderDelegate> delegate;

@end
