//
//  ClyMediaPageController.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/14.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyMediaPageController.h"
#import "ClyVideoListController.h"
#import "ClyRecommendListController.h"

@interface ClyMediaPageController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong) NSArray *arrayLists;


@end

@implementation ClyMediaPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addController];
    [self initScrollView];
    [self addSegmentedController];

    //指定默认控制器
    [self changeController:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
// 添加控制器
-(void) addController{
    
    ClyVideoListController *videoVc =[[ClyVideoListController alloc] init];

    ClyRecommendListController *recomVc = [[ClyRecommendListController alloc] init];

    [self addChildViewController:videoVc];
    [self addChildViewController:recomVc];
    [self.scrollView addSubview:videoVc.view];
    [self.scrollView addSubview:recomVc.view];
}
// 初始化滚动视图
-(void) initScrollView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    self.scrollView.bounces=YES;
    CGFloat contentX = self.childViewControllers.count * kScreenWidth;
    self.scrollView.contentSize = CGSizeMake(contentX, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.pagingEnabled=YES;
}
// 添加段控制器
-(void) addSegmentedController{

    NSArray *arrTitle = @[@"视频",@"推荐"];
    _arrayLists = arrTitle;
    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:arrTitle];
    segmentedControl.layer.cornerRadius = 4;
    segmentedControl.clipsToBounds = YES;
    segmentedControl.frame = CGRectMake(self.view.bounds.size.width/2-84, 4, 177, 26);
    segmentedControl.backgroundColor = RGB_255(40, 130,255);
    
    NSDictionary *titleAttr = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16],UITextAttributeFont,[UIColor lightTextColor],UITextAttributeTextColor,nil];
    segmentedControl.titleTextAttributes = titleAttr;
    
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    segmentedControl.selectionIndicatorHeight = 0.0f;
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
    
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.selectedTitleTextAttributes =@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:16]};
   
    
    segmentedControl.shouldAnimateUserSelection = NO;
    
    
    self.segmentedControl = segmentedControl;
    [self.navigationController.navigationBar addSubview:segmentedControl];
    
    
    
}

- (void)changeController:(long)index{

    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = _scrollView.bounds;
    [self.scrollView addSubview:vc.view];
}


- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);

    self.scrollView.contentOffset = CGPointMake(kScreenWidth*segmentedControl.selectedSegmentIndex, 0);

    [self changeController:segmentedControl.selectedSegmentIndex];
    
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;

    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    [self changeController:page];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
