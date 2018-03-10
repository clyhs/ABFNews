//
//  ClyMenuView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/30.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyMenuView.h"

@implementation ClyMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr{
    self = [super initWithFrame:frame];
    if (self) {
        //
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-22, 15, 44, 44)];
        imageView.image = [UIImage imageNamed:imageStr];
        [self addSubview:imageView];
        
        //
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 15+44, frame.size.width, 20)];
        titleLable.text = title;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLable];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr imageWidth:(CGFloat)width{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-width/2, 15, width, width)];
        imageView.image = [[UIImage imageNamed:imageStr] transformWidth:30 height:30];
        [self addSubview:imageView];
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20+width, frame.size.width, 20)];
        titleLable.text = title;
        titleLable.textColor = fontColor;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont fontWithName:fontNewName size:13];
        [self addSubview:titleLable];
    
    }

    return self;
}

-(id)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)imageStr{

    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/3-20, 12, 20, 20)];
        imageView.image = [[UIImage imageNamed:imageStr] transformWidth:20 height:20];
        [self addSubview:imageView];
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/3, 12, frame.size.width*2/3, 20)];
        titleLable.text = title;
        titleLable.textColor = fontColor;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont fontWithName:fontNewName size:13];
        [self addSubview:titleLable];
    }
    return self;
}

@end
