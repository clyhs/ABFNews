//
//  ClyMAAnnotationView.h
//  ClyNews
//
//  Created by 陈立宇 on 17/1/29.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "ClyCalloutView.h"
#import "ClyAroundAnnotation.h"

@interface ClyMAAnnotationView : MAAnnotationView

@property(nonatomic,strong) ClyCalloutView *calloutView;
@property(nonatomic,strong) ClyAroundAnnotation *aroundAnnotation;

@end
