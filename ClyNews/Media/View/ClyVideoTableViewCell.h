//
//  ClyVideoTableViewCell.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/15.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyVideoInfo.h"
#import "ClyVideoPlayView.h"

@protocol  VideoTableViewCellDelegate<NSObject>

@optional

-(void)clickMoreButton:(ClyVideoInfo *)video;
-(void)clickVideoButton:(NSIndexPath *)indexPath;
-(void)clickCommentButton:(NSIndexPath *)indexPath;

@end

@interface ClyVideoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

+(instancetype)cell;

@property(nonatomic,strong) ClyVideoInfo *videoInfo;

@property (nonatomic, weak) id<VideoTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) ClyVideoPlayView *playView;

@end
