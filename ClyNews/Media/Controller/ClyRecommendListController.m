//
//  ClyRecommendListController.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/14.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyRecommendListController.h"
#import "ClyMJRefreshGifHeader.h"

#import "ClyPlayer.h"


@interface ClyRecommendListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) ClyPlayer *player;
@end

@implementation ClyRecommendListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self addTableView];
    
    //[self addRefreshHeader];
    //_player = [[ClyPlayer alloc] initWithUrl:[NSURL URLWithString:@"http://comke.net/public/upload/video/1.mp4"]];
    
    //[self.view addSubview:_player];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [self.tabBarController.tabBar setHidden:NO];
}


- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tableView];
    
    _tableView = tableView;
}

- (void)addRefreshHeader
{
    ClyMJRefreshGifHeader *header = [ClyMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_header = header;
}



- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //_tableView.frame = self.view.bounds;
    _player.frame = CGRectMake(0, 0, kScreenWidth, 180);
}

- (void)loadData
{
    [self.tableView.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"%i",self.arrayList.count);
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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
