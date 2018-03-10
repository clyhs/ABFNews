//
//  ClyDownloadingCell.h
//  ClyNews
//
//  Created by 陈立宇 on 17/3/7.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZFDownload/ZFDownloadManager.h>

typedef void(^ZFBtnClickBlock)(void);

@interface ClyDownloadingCell : UITableViewCell

@property (strong, nonatomic  ) UILabel          *fileNameLabel;
@property (strong, nonatomic  ) UIProgressView   *progress;
@property (strong, nonatomic  ) UILabel          *progressLabel;
@property (strong, nonatomic  ) UILabel          *speedLabel;
@property (strong, nonatomic  ) UIButton         *downloadBtn;

/** 下载按钮点击回调block */
@property (nonatomic, copy  ) ZFBtnClickBlock  btnClickBlock;
/** 下载信息模型 */
@property (nonatomic, strong) ZFFileModel      *fileInfo;
/** 该文件发起的请求 */
@property (nonatomic,retain ) ZFHttpRequest    *request;

@property (nonatomic,assign)  CGFloat progressValue;


@end
