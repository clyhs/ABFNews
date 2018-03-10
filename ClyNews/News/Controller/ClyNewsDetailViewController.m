//
//  ClyNewsDetailViewController.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/10.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyNewsDetailViewController.h"
#import "ClyNavigationBarView.h"
#import "ClyMJRefreshGifHeader.h"
#import "ClyTitleSectionView.h"
#import "ClyCommentInfo.h"
#import "ClyWebTableViewCell.h"
#import "MXParallaxHeader.h"
#import "ClyNewsTitleHeaderView.h"
#import "ClyLoadingView.h"
#import "ClyCommentReply.h"
#import "ClyNewsCommentViewCell.h"
#import "ClyTitleFooterSectionView.h"
#import "ClyNewsCommentView.h"
#import "ClyCommentView.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

#import <ShareSDKUI/SSUIEditorViewStyle.h>

@interface ClyNewsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,ClyNewsCommentDelegate>
@property(nonatomic,strong) UIWebView *webView;
@property(nonatomic,weak)   UIView *commentToolView;
@property(nonatomic,weak)   UIView *commentView;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,weak) ClyNavigationBarView *navBar;
@property(nonatomic,weak) ClyNewsTitleHeaderView *headerView;
@property(nonatomic,weak) UITextField *inputTextField;

@property(nonatomic,strong) NSArray *hotsComment;
@property(nonatomic,strong) NSArray *newsComment;


@property(nonatomic,assign) BOOL update;

@end

@implementation ClyNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addWebView];
    [self loadWebHtml];
    [self addNavBar];
    [self addTableView];
    [self addHeaderView];
    [self loadData];
    [self addCommentView];
    self.update = YES;
    
    UITapGestureRecognizer *tapgest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackAction)];
    [self.view addGestureRecognizer:tapgest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
    
    //_headerView.newsInfo = _newsInfo;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _tableView.frame = CGRectMake(0, kNavHegiht, kScreenWidth, kScreenHeight-kNavHegiht);
}

//-------------start ui-----------------
-(void) addWebView {
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    webView.backgroundColor = tableWhiteColor;
    webView.scalesPageToFit = NO;
    webView.delegate = self;
    webView.scrollView.bounces = NO;
    [webView setAutoresizingMask:UIViewAutoresizingNone];
    [webView.scrollView setScrollEnabled:NO];
    [webView.scrollView setScrollsToTop:NO];
    _webView = webView;
    
    
}

-(void) addNavBar{
    ClyNavigationBarView *navBar = [ClyNavigationBarView loadInstanceFromNib];
    [self.view addSubview:navBar];
    _navBar = navBar;
}

-(void) addTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = tableWhiteColor;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView = tableView;
    [self.tableView registerClass:[ClyWebTableViewCell class] forCellReuseIdentifier:@"ClyWebTableViewCell"];

}

- (void)addHeaderView
{
    ClyNewsTitleHeaderView *headerView = [ClyNewsTitleHeaderView newsTitleHeaderView];
    headerView.newsInfo = _newsInfo;
    _tableView.parallaxHeader.view = headerView;
    _tableView.parallaxHeader.height = 76;
    _tableView.parallaxHeader.mode = MXParallaxHeaderModeFill;
    _headerView = headerView;
    NSLog(@"title=%@",_newsInfo.title);
}

-(void)addCommentView{
    
    
    ClyNewsCommentView *commentToolView = [[ClyNewsCommentView alloc] initWithFrame:CGRectMake(0, kScreenHeight-45, kScreenWidth, 45)];
    commentToolView.delegate = self;
    _commentToolView = commentToolView;
    //_commentToolView.hidden = YES;
    [self.view addSubview:commentToolView];

    _bgView = [[UIView alloc] init];
    _bgView.frame = self.view.bounds;
    //3. 背景颜色可以用多种方法看需要咯
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

-(void) shareClick:(id)sender{
    //1、创建分享参数
    //NSArray* imageArray = @[[UIImage images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]];
    if (true) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
            images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]
            url:[NSURL URLWithString:@"http://mob.com"]
            title:@"分享标题" type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        [ShareSDK showShareActionSheet:nil
            items:nil shareParams:shareParams
            onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                        message:nil
                        delegate:nil
                        cancelButtonTitle:@"确定"
                        otherButtonTitles:nil];
                               [alertView show];
                               break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                        message:[NSString stringWithFormat:@"%@",error]
                        delegate:nil
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                }
         ];}
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


//----------------------------


-(void) loadData{
    
    [ClyLoadingView showLoadingInView:self.view edgeInset:UIEdgeInsetsMake(kNavHegiht, 0, 0, 0)];
    
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
    //[self.tableView.mj_header endRefreshing];
}

//-----------table------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"%i",self.arrayList.count);
    NSInteger hotsCount = self.hotsComment.count;
    NSInteger newsCount = self.newsComment.count;
    if(section == 0){
        return 1;
    }
    else if(section == 1){
        return hotsCount;
    }else if(section == 2){
        return newsCount;
    }
    
    return 0;
}

#pragma mark -UITableViewDataSource 返回tableView每一组section的HeaderView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ClyTitleSectionView *sectionView = [[ClyTitleSectionView alloc] init];
    if (section == 1) {
        sectionView.title =@"最热评论";
    } else if(section == 2) {
        sectionView.title =@"最新评论";
    } else{
        return nil;
    }
    return sectionView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if(section == 1){
    
        ClyTitleFooterSectionView *footerView = [[ClyTitleFooterSectionView alloc] init];
        footerView.title = @"查看更多跟帖";
        __typeof (self) __weak weakSelf = self;
        [footerView setClickedHandle:^{
            //[weakSelf gotoCommentViewController];
        }];
        return footerView;
    }
    

    return nil;
}


-(NSArray *) commentsInSection:(NSInteger)section{
    
    if(section == 1){
        return _hotsComment;
    }else if(section == 2){
        return _newsComment;
    }
    
    return nil;
}

-(ClyCommentInfo *) commentInIndexPath:(NSIndexPath *) indexPath{
    
    return [self commentsInSection:indexPath.section][indexPath.row];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ID = @"CommentTableViewCell";
    if(indexPath.section == 0){
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell.contentView addSubview:_webView];
            /* 忽略点击效果 */
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }else{
        
        ClyNewsCommentViewCell *cell = [[ClyNewsCommentViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
        cell.commentInfo = [self commentInIndexPath:indexPath];
        return cell;
        
        
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){

        return _webView.frame.size.height;
    }
    if(indexPath.section == 1 || indexPath.section ==2 ){
    
        ClyCommentInfo *commentInfo = [self commentInIndexPath:indexPath];
        return 55+commentInfo.contentHeight+commentInfo.replyHeight+10+20;

    }
    
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 0;
    }
    
    return 30;
}
-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}


//*********webView*******

- (void)loadWebHtml
{
    NSURL *cssURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"News" ofType:@"css"]];
    //NSLog(@"html:%@",_newsInfo.content);
    [_webView loadHTMLString:[self handleWithHtmlBody:self.newsInfo.content] baseURL:cssURL];
}

- (NSString *)handleWithHtmlBody:(NSString *)htmlBody
{
    NSString *html = [htmlBody stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSString *cssName = @"News.css";
    NSMutableString *htmlString =[[NSMutableString alloc]initWithString:@"<html>"];
    [htmlString appendString:@"<head><meta charset=\"UTF-8\">"];
    [htmlString appendString:@"<link rel =\"stylesheet\" href = \""];
    [htmlString appendString:cssName];
    [htmlString appendString:@"\" type=\"text/css\" />"];
    [htmlString appendString:@"</head>"];
    [htmlString appendString:@"<body>"];
    [htmlString appendString:html];
    [htmlString appendString:@"</body>"];
    [htmlString appendString:@"</html>"];
    return htmlString;
}


#pragma mark -UIWebViewDelegate-将要加载Webview
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

-(void) webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"start load");

}
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finish load");
    CGFloat height = [[_webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]floatValue]+12;
    self.webView.frame = CGRectMake(self.webView.frame.origin.x,self.webView.frame.origin.y, kScreenWidth, height);
    [self.tableView reloadData];
    [ClyLoadingView hideLoadingForView:self.view];
    _commentToolView.hidden = NO;
}

- (void)goBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
