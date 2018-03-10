//
//  ClyVideoPlayView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/18.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol VideoPlayViewDelegate <NSObject>

@optional

- (void)videoplayViewSwitchOrientation:(BOOL)isFull;

@end

@interface ClyVideoPlayView : UIView


+ (instancetype)videoPlayView;

@property (weak, nonatomic) id<VideoPlayViewDelegate> delegate;

@property (nonatomic, strong) AVPlayerItem *playerItem;

-(void)suspendPlayVideo;

-(void)resetPlayView;


@end
