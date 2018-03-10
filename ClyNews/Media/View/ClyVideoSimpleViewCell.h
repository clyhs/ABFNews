//
//  ClyVideoSimpleViewCell.h
//  ClyNews
//
//  Created by 陈立宇 on 17/2/13.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyVideoInfo.h"
#import "ClyVideoPlayView.h"
#import "ZFPlayer.h"

@protocol  ClyVideoSimpleViewCellDelegate<NSObject>

@optional

-(void)clickMoreButton:(ClyVideoInfo *)video;
-(void)clickVideoButton:(NSIndexPath *)indexPath;
-(void)clickCommentButton:(NSIndexPath *)indexPath;
-(void)clickDownloadButton;

@end

typedef void(^PlayBtnCallBackBlock)(UIButton *);

@interface ClyVideoSimpleViewCell : UITableViewCell

@property (weak,nonatomic)   UIView   *bgView;
@property (weak,nonatomic)   IBOutlet UIImageView *videoImg;
@property (weak,nonatomic)   IBOutlet UIView *bottomView;

@property (nonatomic,assign) Boolean  bottomHidden;
@property (nonatomic,weak)   UIButton *downloadBtn;
@property (nonatomic,weak)   UILabel  *downloadLabel;


+(instancetype)cell;

@property(nonatomic,strong)  ClyVideoInfo *videoInfo;

@property (nonatomic,weak)   id<ClyVideoSimpleViewCellDelegate> delegate;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,weak)   ClyVideoPlayView *playView;
@property (nonatomic,weak)   UIButton *playBtn;

/** 播放按钮block */
@property (nonatomic, copy  ) PlayBtnCallBackBlock  playBlock;

-(void) setVideoInfo:(ClyVideoInfo *)videoInfo hidden:(Boolean) flag;

@end
