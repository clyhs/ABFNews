//
//  ClyVideoListController.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/14.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyVideoListController.h"
#import <AVFoundation/AVFoundation.h>
#import "ClyVideoTableViewCell.h"
#import "ClyLoadingView.h"
#import "ClyVideoInfo.h"
#import "ClyVideoViewModel.h"
#import "ClyNetworkTool.h"
#import "ClyMJRefreshGifHeader.h"
#import "ClyMJRefreshGifFooter.h"
#import "ClyVideoPlayView.h"
#import "ClyVideoCommentViewController.h"

#import "ClyLoadingView.h"
#import "ClyLoadFailedView.h"
#import "ClyUser.h"

#import "ClyVideoSimpleViewCell.h"


#import <ZFDownload/ZFDownloadManager.h>
#import "ZFPlayer.h"

@interface ClyVideoListController ()<UITableViewDelegate,UITableViewDataSource,
ClyVideoSimpleViewCellDelegate,VideoPlayViewDelegate,ZFPlayerDelegate>


@property(nonatomic,strong) NSMutableArray *arrayList;
@property(nonatomic,assign) BOOL update;
@property(nonatomic,strong) ClyVideoViewModel *viewModel;
@property(nonatomic,assign) NSInteger curIndexPage;

//@property (nonatomic, strong) FullViewController *fullVc;
@property (nonatomic, weak) ClyVideoPlayView *playView;
@property (nonatomic, weak) ClyVideoSimpleViewCell *currentSelectedCell;
@property (nonatomic, copy) NSString *currentSkinModel;
@property (nonatomic, assign) BOOL isFullScreenPlaying;

@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;


@end

@implementation ClyVideoListController
-(ClyVideoViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[ClyVideoViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    
    [self addRefreshHeader];
    
    self.update = YES;
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.update == YES) {
        [self.tableView.mj_header beginRefreshing];
        self.update = NO;
    }
    [self.tabBarController.tabBar setHidden:NO];
    
    [self.playerView resetPlayer];
}

- (void)addTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
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
    CGFloat navHeight = self.navigationController.view.frame.size.height;
    CGFloat tarbarHeight = self.tabBarController.view.frame.size.height;
    _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44);
    
}

- (void)loadData
{
    if(!_arrayList){
        [ClyLoadingView showLoadingInView:self.view];
    }
    @weakify(self)
    [[self.viewModel.fetchVideoInfoCommand execute:VideoListUrl]subscribeNext:^(NSArray *arrayM) {
        
        if(_arrayList.count == 0){
            
            self.arrayList = [arrayM mutableCopy];
            
            [self.tableView reloadData];
            [ClyLoadingView hideLoadingForView:self.view];
            _curIndexPage++;
        }else{
            //_arrayList = [arrayM arrayByAddingObjectsFromArray:_arrayList];
            //[self.tableView.mj_footer endRefreshing];
            //[self.tableView reloadData];
            //[ClyLoadingView hideLoadingForView:self.view];
        }
        [self.tableView.mj_header endRefreshing];
        
    } error:^(NSError *error) {
        //NSLog(@"%@",error.userInfo);
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block ClyVideoInfo *model = self.arrayList[indexPath.row];
    
    
    NSString *ID = @"ClyVideoSimpleViewCell";
    
    ClyVideoSimpleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ClyVideoSimpleViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    [cell setVideoInfo:model hidden:false];
    cell.videoInfo.url = @"http://comke.net/public/upload/video/1.mp4";
    
    
    __block NSIndexPath *weakIndexPath = indexPath;
    __block ClyVideoSimpleViewCell *weakCell     = cell;
    __weak typeof(self)  weakSelf      = self;
    // 点击播放的回调
    cell.playBlock = ^(UIButton *btn){
        
        // 分辨率字典（key:分辨率名称，value：分辨率url)
        NSMutableDictionary *dic = @{}.mutableCopy;
        NSString *url = @"";
        // 取出字典中的第一视频URL
        if(weakIndexPath.row == 0){
            url=[url stringByAppendingString:@"http://baobab.wdjcdn.com/1457521866561_5888_854x480.mp4"] ;
        }
        if(weakIndexPath.row == 1){
            url=[url stringByAppendingString:@"http://baobab.wdjcdn.com/14559682994064.mp4"] ;
        }
        if(weakIndexPath.row == 2){
            url=[url stringByAppendingString:@"http://baobab.wdjcdn.com/1458625865688ONE.mp4"] ;
        }
        if(weakIndexPath.row == 3){
            url=[url stringByAppendingString:@"http://baobab.wdjcdn.com/14573563182394.mp4"] ;
        }
        
        NSURL *videoURL = [NSURL URLWithString:url];
        
        ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
        playerModel.title            = model.name;
        playerModel.videoURL         = videoURL;
        playerModel.placeholderImageURLString = model.img;
        playerModel.tableView        = weakSelf.tableView;
        playerModel.indexPath        = weakIndexPath;
        // 赋值分辨率字典
        playerModel.resolutionDic    = dic;
        // player的父视图
        playerModel.fatherView       = weakCell.bgView;
        
        // 设置播放控制层和model
        [weakSelf.playerView playerControlView:weakSelf.controlView playerModel:playerModel];
        // 下载功能
        weakSelf.playerView.hasDownload = YES;
        // 自动播放
        [weakSelf.playerView autoPlayTheVideo];
    };

    
    return cell;
}


#pragma mark 点击某个Cell或点击评论按钮跳转到评论页面
-(void)pushToVideoCommentViewControllerWithIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"pushtovideo");
    
    [self.playView resetPlayView];
    [self.playView removeFromSuperview];
    
    ClyVideoCommentViewController *vc = [[ClyVideoCommentViewController alloc] init];
    
    vc.videoInfo = self.arrayList[indexPath.row];
    vc.sTitle = @"视频";
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KVideoCellHeight-1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (ZFPlayerView *)playerView
{
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        _playerView.delegate = self;
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        _playerView.cellPlayerOnCenter = NO;
        
        // 当cell划出屏幕的时候停止播放
        // _playerView.stopPlayWhileCellNotVisable = YES;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        // 静音
        // _playerView.mute = YES;
    }
    return _playerView;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
    }
    return _controlView;
}

#pragma mark - ZFPlayerDelegate

- (void)zf_playerDownload:(NSString *)url {
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
    NSString *name = [url lastPathComponent];
    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
    // 设置最多同时下载个数（默认是3）
    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"download"];
    
    
}

-(void)clickCommentButton:(NSIndexPath *)indexPath{
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushToVideoCommentViewControllerWithIndexPath:indexPath];
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
