//
//  ClyWebTableViewCell.h
//  ClyNews
//
//  Created by 陈立宇 on 17/2/11.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClyWebTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^webViewDidFinishLoad)(void);

@property (nonatomic,assign) CGFloat webHeight;

- (instancetype)initWithHtmlBody:(NSString *)htmlBody;



@end
