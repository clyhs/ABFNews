//
//  ClyVideoCommentHeaderView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/3/3.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyVideoCommentHeaderView.h"

@interface ClyVideoCommentHeaderView()<ClyVideoSimpleViewCellDelegate>

@property(nonatomic,weak) UIView *sView;

@end

@implementation ClyVideoCommentHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *) title{
    
    
    if (self = [super initWithFrame:frame]) {
        /* 添加子控件的代码*/
        _title = title;
        self.backgroundColor = tableWhiteColor;
        [self addSView];
        [self addTitleLabel];
        //[self addInputLabel];
        //[self addDownloadBtn];
    }
    
    
    return self;
    
}



-(void) addSView{
    
    UIView *sView = [[UIView alloc] init];
    sView.frame = CGRectMake(0, 0, kScreenWidth, 44);
    [self addSubview:sView];
    _sView = sView;
    
}

-(void) addTitleLabel{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(18, 0, 50, 44);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont fontWithName:fontNewName size:16];
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.text = _title ;
    [self.sView addSubview:titleLabel];
}

-(void) addDownloadBtn{
    
    UILabel  *downloadLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 15, 160, 44)];
    downloadLabel.textColor = fontColor;
    downloadLabel.font = [UIFont fontWithName:fontNewName size:14];
    downloadLabel.text = @"";
    downloadLabel.textAlignment = NSTextAlignmentCenter;
    //[_sView addSubview: downloadLabel];
    _downloadLabel = downloadLabel;
    
    UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadBtn.frame = CGRectMake(kScreenWidth-40, 7, 30, 30);
    [downloadBtn setImage:[UIImage imageNamed:@"icon_download2"] forState:UIControlStateNormal];
    [downloadBtn addTarget:self action:@selector(onDownloadClick:) forControlEvents:UIControlEventTouchUpInside];
    [_sView addSubview: downloadBtn];
    _downloadBtn = downloadBtn;
}

-(void) onDownloadClick:(id)sender{
    NSLog(@"download...");
    if ([self.delegate respondsToSelector:@selector(clickDownloadButton)]) {
        [self.delegate clickDownloadButton];
    }
}

@end
