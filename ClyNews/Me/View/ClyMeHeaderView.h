//
//  ClyMeHeaderView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/3.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClyLoginDelegate <NSObject>

@optional
-(void) clickLogin;

@end

@interface ClyMeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *menuView;

@property (weak, nonatomic) IBOutlet UIImageView *userImgView;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property(nonatomic,weak) id<ClyLoginDelegate> delegate;

@end
