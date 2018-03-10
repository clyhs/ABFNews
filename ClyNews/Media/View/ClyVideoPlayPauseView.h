//
//  ClyVideoPlayPauseView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/3/5.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClyVideoPlayPausedViewDelegate<NSObject>

@optional

-(void)testClick;

@required
-(void)sendPlayOrPausedValueToPlayer;
@end
typedef NS_ENUM(NSInteger,ClyPlayerControlState) {
    ClyControlStateNormal,
    ClyControlStateSelected,
};

@interface ClyVideoPlayPauseView : UIView

@property (nonatomic,strong) UIButton *playPauseBtn;
@property (nonatomic,assign) ClyPlayerControlState state;
@property (nonatomic,weak)   id<ClyVideoPlayPausedViewDelegate> delegate;
@property (nonatomic,assign) NSInteger backBtnTouched;

//总时间
@property (nonatomic,strong) UILabel *totalTime;
//标题
@property (nonatomic,strong) UILabel *title;
//返回
@property (nonatomic,strong) UIButton *backBtn;
-(void)show;
-(void)hide;

@end
