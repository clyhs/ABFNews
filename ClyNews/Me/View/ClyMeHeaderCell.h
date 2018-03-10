//
//  ClyMeHeaderCell.h
//  ClyNews
//
//  Created by 陈立宇 on 17/2/21.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClyLoginDelegate <NSObject>

@optional
-(void) clickLogin;

@end

@interface ClyMeHeaderCell : UITableViewCell

@property(nonatomic,weak) UIView *topView;
@property(nonatomic,weak) UIView *menuView;

@property(nonatomic,weak) UIButton *loginBtn;
@property(nonatomic,weak) UILabel *usernameLabel;

@property(nonatomic,weak) id<ClyLoginDelegate> delegate;

@end
