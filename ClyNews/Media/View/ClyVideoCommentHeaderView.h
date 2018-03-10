//
//  ClyVideoCommentHeaderView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/3/3.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClyVideoSimpleViewCell.h"

@interface ClyVideoCommentHeaderView : UIView

@property (nonatomic,weak)  UIButton *downloadBtn;
@property (nonatomic,weak)  UILabel  *downloadLabel;

@property(nonatomic,strong) NSString *title;
@property (nonatomic, weak) id<ClyVideoSimpleViewCellDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *) title;

@end
