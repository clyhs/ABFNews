//
//  ClyDownloadingCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/3/7.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyDownloadingCell.h"

@interface ClyDownloadingCell()

@end

@implementation ClyDownloadingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self addFileNameLabel];
        [self addProgress];
        [self addProgressLabel];
        [self addSpeedLabel];
        [self addDownloadBtn];
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setFileInfo:(ZFFileModel *)fileInfo{
    _fileInfo = fileInfo;
    _progressValue = (float)[_fileInfo.fileReceivedSize longLongValue] / [_fileInfo.fileSize longLongValue];
    float progress = (float)[_fileInfo.fileReceivedSize longLongValue] / [_fileInfo.fileSize longLongValue];
    _progress.progress = progress;
    
    
    NSString *currentSize = [ZFCommonHelper getFileSizeString:_fileInfo.fileReceivedSize];
    NSString *totalSize = [ZFCommonHelper getFileSizeString:_fileInfo.fileSize];
    self.progressLabel.text = [NSString stringWithFormat:@"%@ / %@ (%.2f%%)",currentSize, totalSize, progress*100];
    
    NSString *spped = [NSString stringWithFormat:@"%@/S",[ZFCommonHelper getFileSizeString:[NSString stringWithFormat:@"%lu",[ASIHTTPRequest averageBandwidthUsedPerSecond]]]];
    _speedLabel.text = spped;
}

-(void) addFileNameLabel{
    
    
    UILabel *filenameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth-30-50, 18)];
    filenameLabel.text = _fileInfo.fileName;
    filenameLabel.font = [UIFont fontWithName:fontNewName size:14];
    filenameLabel.textColor = fontColor;
    filenameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:filenameLabel];
    _fileNameLabel = filenameLabel;
}

-(void) addProgress{
    UIProgressView *progressv = [[UIProgressView alloc] initWithFrame:CGRectMake(15, 10+18+3, kScreenWidth-30-50, 2)];
    //_progress.progress = 0;
    progressv.progressTintColor = navigationBarColor;
    progressv.trackTintColor = [UIColor lightGrayColor];
    //_progress.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:progressv];
    
    _progress = progressv;
}

-(void) addProgressLabel{

    UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10+18+3+2+3, 150, 15)];
    //_progressLabel.text = @"下载进度";
    progressLabel.font = [UIFont fontWithName:fontNewName size:12];
    progressLabel.textColor = fontColor;
    progressLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:progressLabel];
    _progressLabel = progressLabel;
    
    
}

-(void) addDownloadBtn{
    
    UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadBtn.frame = CGRectMake(kScreenWidth-15-50, 10, 50, 44);
    [downloadBtn setImage:[UIImage imageNamed:@"menu_pause"] forState:UIControlStateNormal];
    [downloadBtn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateSelected];
    [downloadBtn addTarget:self action:@selector(clickDownload:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:downloadBtn];
    _downloadBtn =downloadBtn;

}

-(void) addSpeedLabel{
    
    

    UILabel *speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-30-50-80, 10+18+3+2+3, 80, 15)];
    
    speedLabel.font = [UIFont fontWithName:fontNewName size:12];
    speedLabel.textColor = fontColor;
    speedLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:speedLabel];
    _speedLabel = speedLabel;
    if (_fileInfo.downloadState == ZFDownloading) { //文件正在下载
        self.downloadBtn.selected = NO;
    } else if (_fileInfo.downloadState == ZFStopDownload&&!_fileInfo.error) {
        self.downloadBtn.selected = YES;
        self.speedLabel.text = @"已暂停";
    }else if (_fileInfo.downloadState == ZFWillDownload&&!_fileInfo.error) {
        self.downloadBtn.selected = YES;
        self.speedLabel.text = @"等待下载";
    } else if (_fileInfo.error) {
        self.downloadBtn.selected = YES;
        self.speedLabel.text = @"错误";
    }
}


-(void)clickDownload:(UIButton *)sender {
    // 执行操作过程中应该禁止该按键的响应 否则会引起异常
    sender.userInteractionEnabled = NO;
    ZFFileModel *downFile = self.fileInfo;
    ZFDownloadManager *filedownmanage = [ZFDownloadManager sharedDownloadManager];
    if(downFile.downloadState == ZFDownloading) { //文件正在下载，点击之后暂停下载 有可能进入等待状态
        self.downloadBtn.selected = YES;
        [filedownmanage stopRequest:self.request];
    } else {
        self.downloadBtn.selected = NO;
        [filedownmanage resumeRequest:self.request];
    }
    
    // 暂停意味着这个Cell里的ASIHttprequest已被释放，要及时更新table的数据，使最新的ASIHttpreqst控制Cell
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
    sender.userInteractionEnabled = YES;
}




@end
