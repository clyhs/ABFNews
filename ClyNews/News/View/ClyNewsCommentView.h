//
//  ClyNewsCommentView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/2/13.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClyNewsCommentDelegate <NSObject>

@optional

-(void) pinglun:(id) sender;
-(void) shareClick:(id) sender;

@end


@interface ClyNewsCommentView : UIView

@property(nonatomic,weak) id<ClyNewsCommentDelegate> delegate;


@end
