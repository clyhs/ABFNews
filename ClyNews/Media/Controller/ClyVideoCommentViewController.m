//
//  ClyVideoCommentViewController.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/20.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyVideoCommentViewController.h"

#import "ClyVideoInfo.h"
#import "ClyUser.h"
#import "ClyNavigationBarView.h"
#import <MJExtension.h>
#import "ClyMJRefreshGifHeader.h"
#import "ClyCommentInfo.h"
#import "ClyTitleSectionView.h"

#import "ClyVideoSimpleViewCell.h"
#import "ClyNewsCommentViewCell.h"
#import "ClyLoadingView.h"
#import "ClyNewsCommentView.h"
#import "ClyCommentView.h"
#import "HSDownloadManager.h"
#import "ClyVideoCommentHeaderView.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <ZFDownload/ZFDownloadManager.h>
#import "ZFPlayer.h"
#import "UINavigationController+FDFullscreenPopGesture.h"


@interface ClyVideoCommentViewController ()<ClyVideoSimpleViewCellDelegate,VideoPlayViewDelegate,
UITableViewDelegate,UITableViewDataSource,ClyNewsCommentDelegate,ZFPlayerDelegate>

@property(nonatomic,weak)   UIView *commentToolView;
@property(nonatomic,weak)   UIView *commentView;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,weak)   UITextField *inputTextField;

@property(nonatomic,weak)   UILabel *videoTitle;

@property(nonatomic,weak)   ClyNavigationBarView *navBar;

@property(nonatomic,weak)   ClyVideoSimpleViewCell *headerVideoCell;
@property(nonatomic,weak)   ClyVideoPlayView *videoPlayView;
@property(nonatomic,weak)   UIView *headerVideoView;


@property(nonatomic,strong) NSArray *hotsComment;
@property(nonatomic,strong) NSArray *newsComment;

@property(nonatomic,assign) BOOL update;

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIButton *beginBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (strong, nonatomic) ZFPlayerView *playerView;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;

@end

@implementation ClyVideoCommentViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    [self addNavBar];
    
    [self addHeaderVideo];
    
    [self addTableView];
    [self addVideoTitleLabel];
    [self addRefreshHeader];
    [self addCommentView];
    self.update = YES;
    
    _beginBtn = _headerVideoCell.downloadBtn;
    _titleLabel = _headerVideoCell.downloadLabel;
    
    NSLog(@"stitle=%@",self.sTitle);
    
    UITapGestureRecognizer *tapgest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackAction)];
    [self.view addGestureRecognizer:tapgest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.headerVideoCell.bottomHidden = true;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if (self.update == YES) {
        [self.tableView.mj_header beginRefreshing];
        self.update = NO;
    }
    [self.tabBarController.tabBar setHidden:YES];
}

//添加导航条
-(void) addNavBar{
    ClyNavigationBarView *navBar = [ClyNavigationBarView loadInstanceFromNib];
    navBar.frame = CGRectMake(0, 0, kScreenWidth, kNavHegiht);
    __typeof (self) __weak weakSelf = self;
    /*
    navBar.navBackHandle =^{
    };*/
    [navBar setNavBackHandle:^{
        [weakSelf goBackAction];
    }];
     
    [navBar setTitle:self.sTitle];
    [self.view addSubview:navBar];
    _navBar = navBar;
}

//添加视频
-(void) addHeaderVideo{
    // 创建header
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, kNavHegiht, kScreenWidth, kVideoPlayHeight);
    ClyVideoSimpleViewCell *cell = [ClyVideoSimpleViewCell cell];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.playBlock =^(UIButton *btn){
        NSLog(@"hhhh");
        [self.playerView autoPlayTheVideo];
    };
    
    self.headerVideoCell = cell;
    cell.delegate = self;
    [cell setVideoInfo:self.videoInfo hidden:true];
    cell.frame = CGRectMake(0, 0, kScreenWidth, kVideoPlayHeight);
    cell.contentView.frame = cell.bounds;
    header.height = kVideoPlayHeight;
    [self.view addSubview:header];
    [header addSubview:cell];
    
}
//添加视频标题
-(void) addVideoTitleLabel{
    
    ClyVideoCommentHeaderView *hv = [[ClyVideoCommentHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) title:_videoInfo.name];
    hv.delegate = self;
    _tableView.tableHeaderView = hv;
    
}

- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    //tableView.backgroundColor = RGB_255(245, 245, 245);
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0 , 0, 0, 0);
    _tableView = tableView;
}

- (void)addRefreshHeader
{
    [self loadData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //_tableView.frame = self.view.bounds;
    _tableView.frame = CGRectMake(0, kVideoPlayHeight+kNavHegiht-1, kScreenWidth, kScreenHeight-kVideoPlayHeight-kNavHegiht+1);
    
    
}

-(void)addCommentView{
    

    ClyNewsCommentView *commentToolView = [[ClyNewsCommentView alloc] initWithFrame:CGRectMake(0, kScreenHeight-45, kScreenWidth, 45)];
    commentToolView.delegate = self;
    _commentToolView = commentToolView;
    //_commentToolView.hidden = YES;
    [self.view addSubview:commentToolView];

    _bgView = [[UIView alloc] init];
    _bgView.frame = self.view.bounds;
    _bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    [self.view addSubview:_bgView];
    _bgView.hidden = YES;
    
    ClyCommentView *commentView = [[ClyCommentView alloc] initWithFrame:CGRectMake(0, kScreenHeight-90, kScreenWidth, 90)];
    _commentView = commentView;
    _inputTextField = commentView.inputTextField;
    [_bgView addSubview:commentView];
    
}


-(void) pinglun:(id)sender{
    NSLog(@"...");
    _bgView.hidden = NO;
    _inputTextField.becomeFirstResponder ;
}

- (void)tapBackAction {
    
    _bgView.hidden = YES;
    [self.view endEditing:YES];
    
}

- (void)keyBoardWillShow:(NSNotification *) note {
    NSLog(@"keyboard");
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];

    void (^animation)(void) = ^void(void) {
        //_bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.commentView.transform = CGAffineTransformMakeTranslation(0, - keyBoardHeight);
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
    
}

- (void)keyBoardWillHide:(NSNotification *) note {
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.commentView.transform = CGAffineTransformIdentity;
        
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

-(void) loadData{

    [ClyLoadingView showLoadingInView:self.view];
    
    NSArray *hots = @[
                      @{
                          @"id":@"1",
                          @"content":@"hello world!你个大傻b...hello world!你个大傻b...hello world!你个大傻b...hello world!你个大傻b...hello world!你个大傻b...hello world!你个大傻b...",
                          @"createTime":@"12-01",
                          @"hit":@"14",
                          @"user":@{
                                  @"id":@"1",
                                  @"username":@"admin2",
                                  @"img":@"http://www.comke.net/public/upload/user/img2011-12-1616-11-19.jpg"
                                  },
                          @"replys":@[
                                  @{
                                      @"userId":@"0",
                                      @"username":@"replyer",
                                      @"replyContent":@"你个大sb，哈哈"
                                      },
                                  @{
                                      @"userId":@"0",
                                      @"username":@"replyer",
                                      @"replyContent":@"你个大sb，哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈."
                                      }
                                  ]
                          
                          },
                      @{
                          @"id":@"2",
                          @"content":@"他们都说exo是个大傻b！",
                          @"createTime":@"12-02",
                          @"hit":@"14",
                          @"user":@{
                                  @"id":@"1",
                                  @"username":@"admin2",
                                  @"img":@"http://www.comke.net/public/upload/user/img2011-12-1616-11-19.jpg"
                                  },
                          @"replys":@[
                                  @{
                                      @"userId":@"0",
                                      @"username":@"replyer",
                                      @"replyContent":@"你个大sb，哈哈22"
                                      }
                                  ]
                          }
                      ];
    _hotsComment = [ClyCommentInfo mj_objectArrayWithKeyValuesArray:hots];
    _newsComment = [ClyCommentInfo mj_objectArrayWithKeyValuesArray:hots];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [ClyLoadingView hideLoadingForView:self.view];
    _commentToolView.hidden = NO;
}


- (void)goBackAction
{
    [self.playerView resetPlayer];
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"%i",self.arrayList.count);
    NSInteger hotsCount = self.hotsComment.count;
    NSInteger newsCount = self.newsComment.count;
    
    if(section == 0){
        return hotsCount;
    }else{
        return newsCount;
    }
    
    return 0;
}

#pragma mark -UITableViewDataSource 返回tableView每一组section的HeaderView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    ClyTitleSectionView *sectionView = [[ClyTitleSectionView alloc] init];
    if (section == 0) {

        sectionView.title =@"最热评论";
    } else {
        sectionView.title =@"最新评论";
    }
    //return sectionHeaderLabel;
    return sectionView;
}

-(NSArray *) commentsInSection:(NSInteger)section{

    if(section == 0){
        return _hotsComment;
    }else{
        return _newsComment;
    }

    return nil;
}

-(ClyCommentInfo *) commentInIndexPath:(NSIndexPath *) indexPath{

    return [self commentsInSection:indexPath.section][indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClyNewsCommentViewCell *cell = [[ClyNewsCommentViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
    cell.commentInfo = [self commentInIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClyCommentInfo *commentInfo = [self commentInIndexPath:indexPath];
    return 55+commentInfo.contentHeight+commentInfo.replyHeight+10+20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    if(section == 1){
        return 45;
    }
    return 0.01f;
}




#pragma mark - ZFPlayerDelegate

- (void)zf_playerBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)zf_playerDownload:(NSString *)url {
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
    NSString *name = [url lastPathComponent];
    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
    // 设置最多同时下载个数（默认是3）
    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"download"];
}

#pragma mark - Getter

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = _videoInfo.name;
        _playerModel.videoURL         = [NSURL URLWithString:_videoInfo.url];
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
        _playerModel.fatherView       = self.headerVideoCell.bgView;
        
    }
    return _playerModel;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        
        /*****************************************************************************************
         *   // 指定控制层(可自定义)
         *   // ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
         *   // 设置控制层和播放模型
         *   // 控制层传nil，默认使用ZFPlayerControlView(如自定义可传自定义的控制层)
         *   // 等效于 [_playerView playerModel:self.playerModel];
         ******************************************************************************************/
        [_playerView playerControlView:nil playerModel:self.playerModel];
        
        // 设置代理
        _playerView.delegate = self;
        
        //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
        // self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        
        // 打开下载功能（默认没有这个功能）
        _playerView.hasDownload    = YES;
        
        // 打开预览图
        self.playerView.hasPreviewView = YES;
        
    }
    return _playerView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(velocity.y>0)
    {
        //[_commentToolView setHidden:YES];
        [UIView animateWithDuration:0.5 animations:^{
            _commentToolView.alpha = 0;
        }];
        //_commentToolView.hidden = YES;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            _commentToolView.alpha = 1;
        }];
        //_commentToolView.hidden = NO;
    }
    
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
