//
//  ClyHeader.h
//  ClyNews
//
//  Created by 陈立宇 on 16/12/31.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#ifndef ClyHeader_h
#define ClyHeader_h

#ifdef __OBJC__

#import <UIKit/UIKit.h>

#endif

//#define BaseUrl @"http://www.capitalfamily.cn"
#define BaseUrl @"http://www.comke.net"
#define ArticleListUrl @"/articlelist.php?typeId="
#define VideoListUrl @"/videolistforjson.php"

#define MAPKEY  @"fcb0d242bc704c7ba3dbd68db4a3b761"

#define kVideoPlayHeight 180
#define KVideoCellHeight 236
#define kNavHegiht 44
#define kVideoMarginTop 0



//屏幕高度
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

//屏幕宽度
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)

//颜色 两种参数
#define RGB_255(r,g,b) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1]

#define RGBA_255(r,g,b,a) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:a]

#define navigationBarColor RGB_255(23, 158, 246)
#define separaterColor RGB_255(200, 199, 204)

#define commonColor RGB_255(30, 130, 245)


#define replyCellColor RGB_255(245, 245, 245)

#define tableWhiteColor RGB_255(255,255,255)

#define commonMargin 10

//
#define fontName @"HYQiHei"
#define fontNewName @"HelveticaNeue"
#define fontTitleSize 18
#define fontMini 12
#define fontColor RGB_255(0,0,0)
#define fontHightlightColor RGB_255(23, 158, 246)

#define cellColor RGB_255(255,255,255)
#define lineColor  RGB_255(236, 236, 236)
#define replyBgColor (245, 245, 245)
#define navBarBgColor RGB_255(23, 158, 246)

#define margin_common 10

//

#endif /* ClyHeader_h */
