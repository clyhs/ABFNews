//
//  ClyTabBar.h
//  ClyNews
//
//  Created by 陈立宇 on 16/12/30.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClyTabBarDelegate <NSObject>

@optional

- (void)ChangSelIndexForm:(NSInteger)from to:(NSInteger)to;

@end

@interface ClyTabBar : UIView


@property (nonatomic,weak) id<ClyTabBarDelegate> delegate;

- (void)addImageView;
- (void)addBarButtonWithNorName:(NSString *)nor andDisName:(NSString *)dis andTitle:(NSString *)title;


@end
