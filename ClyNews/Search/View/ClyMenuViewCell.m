//
//  ClyMenuViewCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/17.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyMenuViewCell.h"

@interface ClyMenuViewCell(){

    UIView *sView;
}
@end

@implementation ClyMenuViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        sView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
        
        for(int i = 0; i < 8; i++){
            
            if (i < 4) {
                CGRect frame = CGRectMake(i*kScreenWidth/4, 0, kScreenWidth/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imageStr = [menuArray[i] objectForKey:@"image"];
                
                ClyMenuView *btnView = [[ClyMenuView alloc] initWithFrame:frame title:title imageStr:imageStr imageWidth:30];
                
                btnView.tag = 10+i;
                [sView addSubview:btnView];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                if( i > 0 && i < 4){
                    [self addLeftLineView:i y:0];
                }
            
            }else if(i<8){
            
                CGRect frame = CGRectMake((i-4)*kScreenWidth/4, 80, kScreenWidth/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imageStr = [menuArray[i] objectForKey:@"image"];
                ClyMenuView *btnView = [[ClyMenuView alloc] initWithFrame:frame title:title imageStr:imageStr imageWidth:30];
                btnView.tag = 10+i;
                
                [sView addSubview:btnView];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                if( i > 4 && i < 8){
                    [self addLeftLineView:(i-4) y:80];
                }
            }
            [self addLineView:0];
            [self addLineView:80];
            [self addLineView:160];
        }
        [self addSubview:sView];
    
    }
    return self;
}

-(void) addLineView:(CGFloat) height {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height-0.2, kScreenWidth, 0.8)];
    lineView.backgroundColor = lineColor;
    [sView addSubview:lineView];
}

-(void) addLeftLineView:(NSInteger) index y:(CGFloat) y{
    NSLog(@"index=%ld,y=%f",index,y);
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/4*index, y, 0.8, 80)];
    lineView.backgroundColor = lineColor;
    [sView addSubview:lineView];
}
-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    NSLog(@"tag:%ld",sender.view.tag);
}

@end
