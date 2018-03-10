//
//  ClyDownloadedCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/3/7.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyDownloadedCell.h"
#import <ZFDownload/ZFDownloadManager.h>

@implementation ClyDownloadedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setFileInfo:(ClyFileInfo *)fileInfo{
    _fileInfo = fileInfo;
    [self addFileImageView];
    [self addFilenameLabel];
    [self addFilesizeLabel];
    
}

-(void) addFileImageView{
    
    _fileImageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 38, 40)];
    _fileImageIcon.image = [UIImage imageNamed:@"video_icon"];
    _fileImageIcon.backgroundColor = [UIColor clearColor];
    [self addSubview:_fileImageIcon];

}

-(void) addFilenameLabel{
    _filenameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*2+38, 12, kScreenWidth-15-15*2+38, 20)];
    _filenameLabel.text = _fileInfo.filename;
    _filenameLabel.font = [UIFont fontWithName:fontNewName size:14];
    _filenameLabel.textColor = fontColor;
    _filenameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_filenameLabel];
}

-(void) addFilesizeLabel{
    _filesizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-100, 12+20+3, 80, 12)];
    NSString *totalSize = [ZFCommonHelper getFileSizeString:_fileInfo.filesize];
    _filesizeLabel.text = totalSize;
    _filesizeLabel.font = [UIFont fontWithName:fontNewName size:12];
    _filesizeLabel.textColor = fontColor;
    _filesizeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_filesizeLabel];
    
}

@end
