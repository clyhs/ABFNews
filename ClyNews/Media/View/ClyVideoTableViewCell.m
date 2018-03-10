//
//  ClyVideoTableViewCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/15.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyVideoTableViewCell.h"
#import "ClyUser.h"
#import <SDWebImageManager.h>

@interface ClyVideoTableViewCell()<VideoPlayViewDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *hit;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *hotComment;

@property (weak, nonatomic) IBOutlet UILabel *videoTime;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;


@end

@implementation ClyVideoTableViewCell

+(instancetype)cell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
    //[SDWebImageManager sharedManager].delegate = self;
    
   

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setVideoInfo:(ClyVideoInfo *) videoInfo{

    _videoInfo = videoInfo;
    
    self.name.text = self.videoInfo.name;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:self.videoInfo.img] placeholderImage:[UIImage imageNamed:@"newsIcon"] options:SDWebImageRefreshCached];
    [self.img setContentMode:UIViewContentModeScaleAspectFit];
    self.img.layer.masksToBounds = NO;
    self.hit.text = @"111";
    self.createTime.text = self.videoInfo.createTime;
    self.hotComment.text = @"sdfsdfdfdsf.........";
    self.videoTime.text = self.videoInfo.videoTime;
    //self.username.text =[self.videoInfo.user.username stringByAppendingString:@"123"];
    
    
    self.username.text = videoInfo.user.username;
    [self.userImg sd_setImageWithURL:videoInfo.user.img placeholderImage:[UIImage imageNamed:@""]];
    //UIImageView *userImg = [[UIImageView alloc] init];
    self.userImg.layer.masksToBounds = YES;
    self.userImg.layer.cornerRadius = self.userImg.bounds.size.width*0.5;
    self.userImg.layer.borderWidth = 2.0;
    self.userImg.layer.borderColor = [UIColor whiteColor].CGColor;
    
   
    
}
- (IBAction)playVideo:(id)sender {
    NSLog(@"playVideo");
    if ([self.delegate respondsToSelector:@selector(clickVideoButton:)]) {
        [self.delegate clickVideoButton:self.indexPath];
    }
    
}
- (IBAction)ding:(id)sender {
    
    UIButton *dingBtn = (UIButton *)sender;

    dingBtn.selected = !dingBtn.selected;
    
    [dingBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    [dingBtn setImage:[UIImage imageNamed:@"mainCellDingClick"] forState:UIControlStateSelected];
}
- (IBAction)comment:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickCommentButton:)]) {
        [self.delegate clickCommentButton:self.indexPath];
    }
    
}
- (IBAction)share:(id)sender {
}

-(void) setFrame:(CGRect)frame{

    frame.size.width = kScreenWidth;
    frame.size.height = KVideoCellHeight;
    [super setFrame:frame];
}

/*

- (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL {
    
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    // 获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪
    CGContextClip(context);
    
    // 将图片画上去
    [image drawInRect:rect];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}*/

@end
