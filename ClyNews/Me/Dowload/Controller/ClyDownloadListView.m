//
//  ClyDownloadListView.m
//  ClyNews
//
//  Created by 陈立宇 on 17/3/7.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyDownloadListView.h"
#import <ZFDownload/ZFDownloadManager.h>
#import "ClyFileInfo.h"
#import "ClyDownloadedCell.h"
#import "ClyDownloadingCell.h"
#import "ClyNavigationBarView.h"
#import "ClyTitleSectionView.h"

#define  DownloadManager  [ZFDownloadManager sharedDownloadManager]

@interface ClyDownloadListView ()<UITableViewDataSource,UITableViewDelegate,
ZFDownloadDelegate>

@property(nonatomic,weak)   ClyNavigationBarView *navBar;

@property (weak, nonatomic) UITableView    *tableView;
@property (atomic, strong ) NSMutableArray *downloadObjectArr;
@property (nonatomic,weak)  UIButton *rightBtn;
@property (nonatomic,strong) NSMutableArray *downloading;
@property (nonatomic,strong) NSMutableArray *downloaded;
@property (nonatomic,assign) NSInteger sectionNum;

@end

@implementation ClyDownloadListView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavBar];
    [self addTableView];
    
    DownloadManager.downloadDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"download"] == YES){
        _rightBtn.selected = YES;
    }else{
        _rightBtn.selected = NO;
    }
    // 更新数据源
    [self initData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //_tableView.frame = self.view.bounds;
    _tableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
}



//添加导航条
-(void) addNavBar{

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 22, 40, 28);
    //[backBtn setImage:[UIImage imageNamed:@"back_bg"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont fontWithName:fontNewName size: 16.0];
    [backBtn addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem  *leftItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[UIFont fontWithName:fontNewName size:20],NSFontAttributeName,nil]];
    [self.navigationItem setTitle:@"本地视频"];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(kScreenWidth-60, 22, 40, 28);
    [rightBtn setTitle:@"开始" forState:UIControlStateNormal];
    [rightBtn setTitle:@"暂停" forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont fontWithName:fontNewName size: 16.0];
    UIBarButtonItem  *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightItem];
    _rightBtn = rightBtn;
    
    
}
- (void)addTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0 , 0, 0, 0);
    _tableView = tableView;
    
    
    [self.tableView registerClass:[ClyDownloadedCell class] forCellReuseIdentifier:@"ClyDownloadedCell"];
    [self.tableView registerClass:[ClyDownloadingCell class] forCellReuseIdentifier:@"ClyDownloadingCell"];
}

- (void)goBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editClick:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if(sender.selected){
        //[DownloadManager start]
        [DownloadManager startAllDownloads];
    }else{
        //[DownloadManager pus]
        [DownloadManager pauseAllDownloads];
    }

}
- (void)initData {
    [DownloadManager startLoad];
    NSMutableArray *downladed = DownloadManager.finishedlist;
    NSMutableArray *downloading = DownloadManager.downinglist;
    _downloading = downloading;
    _downloaded = downladed;
    self.downloadObjectArr = @[].mutableCopy;
    [self.downloadObjectArr addObject:downladed];
    [self.downloadObjectArr addObject:downloading];
    [self.tableView reloadData];
    
    _sectionNum = 2;
}

//-------------table start-----------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = self.downloadObjectArr[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ClyDownloadedCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"ClyDownloadedCell"];
        if (cell == nil) {
            cell = [[ClyDownloadedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClyDownloadedCell"];
        }
        ZFFileModel *fileInfo = self.downloadObjectArr[indexPath.section][indexPath.row];
        //cell.fileInfo = fileInfo;
        ClyFileInfo *f = [[ClyFileInfo alloc] init];
        f.filename = fileInfo.fileName;
        f.filesize = fileInfo.fileSize;
        cell.fileInfo = f;
        return cell;
    } else if (indexPath.section == 1) {
        ClyDownloadingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClyDownloadingCell"];
        
        if (cell == nil) {
            cell = [[ClyDownloadingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClyDownloadingCell"];
        }
        ZFHttpRequest *request = self.downloadObjectArr[indexPath.section][indexPath.row];
        if (request == nil) { return nil; }
        ZFFileModel *fileInfo = [request.userInfo objectForKey:@"File"];
        cell.fileInfo = fileInfo;
        
        
        __weak typeof(self) weakSelf = self;
        // 下载按钮点击时候的要刷新列表
        cell.btnClickBlock = ^{
            [weakSelf initData];
        };
        // 下载模型赋值
        cell.fileInfo = fileInfo;
        // 下载的request
        cell.request = request;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 50;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark -UITableViewDataSource 返回tableView每一组section的HeaderView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ClyTitleSectionView *sectionView = [[ClyTitleSectionView alloc] init];
    if(section == 0){
        sectionView.title =@"已经下载";
    }else{
        sectionView.title =@"正在下载";
    }
    return sectionView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(_sectionNum > 0){
        
        if (indexPath.section == 0) {
            ZFFileModel *fileInfo = self.downloadObjectArr[indexPath.section][indexPath.row];
            [DownloadManager deleteFinishFile:fileInfo];
        }else if (indexPath.section == 1) {
            ZFHttpRequest *request = self.downloadObjectArr[indexPath.section][indexPath.row];
            [DownloadManager deleteRequest:request];
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
    
    
    
    
    
}

//--------------------------

#pragma mark - ZFDownloadDelegate

// 开始下载
- (void)startDownload:(ZFHttpRequest *)request {
    NSLog(@"开始下载!");
}

// 下载中
- (void)updateCellProgress:(ZFHttpRequest *)request {
    ZFFileModel *fileInfo = [request.userInfo objectForKey:@"File"];
    [self performSelectorOnMainThread:@selector(updateCellOnMainThread:) withObject:fileInfo waitUntilDone:YES];
}

// 下载完成
- (void)finishedDownload:(ZFHttpRequest *)request {
    [self initData];
}

// 更新下载进度
- (void)updateCellOnMainThread:(ZFFileModel *)fileInfo {
    NSArray *cellArr = [self.tableView visibleCells];
    for (id obj in cellArr) {
        if([obj isKindOfClass:[ClyDownloadingCell class]]) {
            ClyDownloadingCell *cell = (ClyDownloadingCell *)obj;
            if([cell.fileInfo.fileURL isEqualToString:fileInfo.fileURL]) {
                cell.fileInfo = fileInfo;
            }
            //[_tableView reloadData];
        }
    }
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
