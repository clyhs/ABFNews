//
//  ClyNewsViewController.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/12.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyNewsViewController.h"


#import "ClyNewsViewModel.h"
#import "ClyNewsDetailViewController.h"

#import "ClyNetworkTool.h"
#import "ClyMJRefreshGifHeader.h"
#import "ClyMJRefreshGifFooter.h"

#import "ClyLoadingView.h"
#import "ClyLoadFailedView.h"
#import "ClyNewsSimpleViewCell.h"
#import "ClyNewsImageViewCell.h"



@interface ClyNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *arrayList;
@property(nonatomic,assign) BOOL update;
@property(nonatomic,strong) ClyNewsViewModel *viewModel;
@property(nonatomic,assign) NSInteger curIndexPage;

@property(weak,nonatomic) UILabel *label;

@end

static NSString *newsImageCellId  = @"ClyNewsTableViewCell";
static NSString *newsSimpleCellId = @"ClyNewsSimpleCell";

@implementation ClyNewsViewController





-(ClyNewsViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[ClyNewsViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableView];
    [self addRefreshHeader];
    
    self.update = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.update == YES) {
        [self.tableView.mj_header beginRefreshing];
        self.update = NO;
    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _tableView.frame = self.view.bounds;
}

- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    _tableView = tableView;
    tableView.backgroundColor = tableWhiteColor;
}

- (void)addRefreshHeader
{
    ClyMJRefreshGifHeader *header = [ClyMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_header = header;
}

/*
- (BOOL)prefersStatusBarHidden
{
    return YES;
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadData
{
    NSInteger curIndexPage = _curIndexPage;
    curIndexPage = 1;
    
    NSString *allUrlstring = [NSString stringWithFormat:@"%@",self.urlString];
    NSString *page = [NSString stringWithFormat:@"&pageNo=%ld",curIndexPage];
    [self loadDataForType:1 withURL:[allUrlstring stringByAppendingString:page]];
}

// ------公共方法
- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
    
    if(!_arrayList){
        [ClyLoadingView showLoadingInView:self.view];
    }
    @weakify(self)
    [[self.viewModel.fetchNewsInfoCommand execute:allUrlstring]subscribeNext:^(NSArray *arrayM) {
        
        if(_arrayList.count == 0){
        
            self.arrayList = [arrayM mutableCopy];
            
            [self.tableView reloadData];
            [ClyLoadingView hideLoadingForView:self.view];
            _curIndexPage++;
        }else{
        
            _arrayList = [arrayM arrayByAddingObjectsFromArray:_arrayList];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            //[ClyLoadingView hideLoadingForView:self.view];
        }
        [self.tableView.mj_header endRefreshing];
        
    } error:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
        [self.tableView.mj_header endRefreshing];
        [ClyLoadingView hideLoadingForView:self.view];
        if (_arrayList.count == 0) {
            __weak typeof(self) weakSelf = self;
            [ClyLoadFailedView showLoadFailedInView:self.view retryHandle:^{
                [weakSelf loadData];
            }];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClyNewsInfo *newsModel = self.arrayList[indexPath.row];

    
    if(!newsModel.hasImage){
        
        ClyNewsSimpleViewCell *cell = [[ClyNewsSimpleViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        cell.newsInfo = newsModel;
        return cell;
    }else{
        
        ClyNewsImageViewCell *cell = [[ClyNewsImageViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
        cell.newsInfo = newsModel;
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClyNewsInfo *newsModel = self.arrayList[indexPath.row];
    if(newsModel.hasImage){
        return 90;
    }else{
        CGFloat viewHeight = 1.5*10+newsModel.titleHeight+newsModel.contentheight+5+18+10;
        return viewHeight;
    }
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ClyNewsDetailViewController *vc = [[ClyNewsDetailViewController alloc] init];
    vc.newsInfo = self.arrayList[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
