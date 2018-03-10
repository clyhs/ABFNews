//
//  ClyMainViewController.m
//  ClyNews
//
//  Created by 陈立宇 on 16/12/29.
//  Copyright © 2016年 陈立宇. All rights reserved.
//

#import "ClyMainViewController.h"
#import "ClyTitleLabel.h"
#import "ClyNewsViewController.h"
#import "ClyLoadingView.h"

static NSUInteger paddingTop = 0;
static NSUInteger smallScrollViewHeight = 40;
static NSUInteger navHeight = 44;

@interface ClyMainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopToTop;
@property (weak, nonatomic) UIView *lineView;

/** 新闻接口的数组 */
@property(nonatomic,strong) NSArray *arrayLists;

@property(nonatomic,strong) UIButton *rightItem;
//@property(nonatomic,strong) ClyLoadingView *newsTableViewController;
@property(nonatomic,strong) ClyNewsViewController *newsViewController;

@end

@implementation ClyMainViewController

#pragma mark - ******************** 懒加载
- (NSArray *)arrayLists
{
    if (_arrayLists == nil) {
        _arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsInfoUrls.plist" ofType:nil]];
    }
    return _arrayLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    self.smallScrollView.showsVerticalScrollIndicator = NO;
    self.smallScrollView.scrollsToTop = NO;
    self.bigScrollView.scrollsToTop = NO;
    self.bigScrollView.delegate = self;
    
    [self addController];
    [self addLabel];
    //[self addRightItem];
    
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScrollView.contentSize = CGSizeMake(contentX, 0);
    self.bigScrollView.pagingEnabled = YES;
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:vc.view];
    
    //UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 36, 60, 2)];
    //lineView.backgroundColor = navigationBarColor;
    //_lineView = lineView;
    ClyTitleLabel *lable = [self.smallScrollView.subviews firstObject];
    lable.lineView.hidden = NO;
    lable.scale = 1.0;
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
    
    self.newsViewController = self.childViewControllers[0];
}

-(void) addRightItem{

    UIButton *rightItem = [[UIButton alloc]init];
    self.rightItem = rightItem;
    UIWindow *win = [UIApplication sharedApplication].windows.firstObject;
    [self.smallScrollView addSubview:rightItem];
    rightItem.y = 20;
    rightItem.width = 45;
    rightItem.height = 45;
    //[rightItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    rightItem.x = [UIScreen mainScreen].bounds.size.width - rightItem.width;
    NSLog(@"%@",NSStringFromCGRect(rightItem.frame));
    [rightItem setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{

}





#pragma mark - ******************** 添加方法

/** 添加子控制器 */
- (void)addController
{
    for (int i=0 ; i<self.arrayLists.count ;i++){
        ClyNewsViewController *vc1 = [[ClyNewsViewController alloc] init];
        vc1.title = self.arrayLists[i][@"title"];
        
        NSNumber *typeId =self.arrayLists[i][@"typeId"] ;
        //vc1.typeId = typeId;
        //vc1.urlString = self.arrayLists[i][@"urlString"];
        NSLog(@"typeId=%@",typeId);
        
        NSString *url =[ArticleListUrl stringByAppendingString:[NSString stringWithFormat:@"%@",typeId]];
        vc1.urlString = url;
        
        [self addChildViewController:vc1];
    }
}

/** 添加标题栏 */
- (void)addLabel
{
    for (int i = 0; i < 5; i++) {
        CGFloat lblW = 60;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        ClyTitleLabel *lbl1 = [[ClyTitleLabel alloc]init];
        UIViewController *vc = self.childViewControllers[i];
        lbl1.text =vc.title;
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        lbl1.font = [UIFont fontWithName:fontName size:16];
        [self.smallScrollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        [lbl1 addSubview:_lineView];
        
        //[lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    self.smallScrollView.contentSize = CGSizeMake(60 * 5, 0);}

#pragma mark - ScrollToTop

- (void)setScrollToTopWithTableViewIndex:(NSInteger)index
{
    //self.newsViewController.tableView.scrollsToTop = NO;
    self.newsViewController = self.childViewControllers[index];
    //self.newsViewController.tableView.scrollsToTop = YES;
}

#pragma mark - ******************** scrollView代理方法

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    
    // 滚动标题栏
    ClyTitleLabel *titleLable = (ClyTitleLabel *)self.smallScrollView.subviews[index];
    //titleLable.backgroundColor = [UIColor yellowColor];
    ////_lineView.backgroundColor = navigationBarColor;
    //[titleLable addSubview:_lineView];
    
    CGFloat offsetx = titleLable.center.x - self.smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    ClyNewsViewController *newsVc = self.childViewControllers[index];
    newsVc.index = index;
    
    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            ClyTitleLabel *temlabel = self.smallScrollView.subviews[idx];
            //temlabel.backgroundColor = [UIColor whiteColor];
            temlabel.scale = 0.0;
            temlabel.lineView.hidden = YES;
            //_lineView.hidden = YES;
            //[_lineView removeFromSuperview];
        }else{
        
            ClyTitleLabel *temlabel = self.smallScrollView.subviews[idx];
            temlabel.lineView.hidden = NO;
            //temlabel.backgroundColor = [UIColor yellowColor];
            //_lineView.backgroundColor = navigationBarColor;
            //[temlabel addSubview:_lineView];
        }
    }];
    
    [self setScrollToTopWithTableViewIndex:index];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:newsVc.view];
}



/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    ClyTitleLabel *labelLeft = self.smallScrollView.subviews[leftIndex];
    //labelLeft.backgroundColor = [UIColor yellowColor];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.smallScrollView.subviews.count) {
        ClyTitleLabel *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
