//
//  ClyMeViewController.m
//  ClyNews
//
//  Created by 陈立宇 on 17/1/3.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyMeViewController.h"
#import "ClyMeHeaderView.h"
#import "MXParallaxHeader.h"
#import "ClyMeTableItem.h"
#import "ClyMeTableViewCell.h"
#import "ClyLoginViewController.h"
#import "AppDelegate.h"
#import "LocationTracker.h"
#import "ClyMeSimpleCell.h"
#import "ClyMeHeaderCell.h"
#import "ClyMeSectionCell.h"
#import "ClyCacheManager.h"
#import "ClyQrCodeViewController.h"
#import "ClyDownloadListView.h"

@interface ClyMeViewController ()<UITableViewDataSource,UITableViewDelegate,ClyLoginDelegate,
UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) ClyMeHeaderView *headerView;
@property (nonatomic, strong) UIImageView *userImgView;

@property LocationTracker * locationTracker;
@property (nonatomic) NSTimer* locationUpdateTimer;

// Data
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic,assign) CGFloat cacheSize;
@property (nonatomic,strong) NSMutableArray *menuArray;

@end

static NSString *tableItemCellId = @"ClyMeTableViewCell";

@implementation ClyMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    [self addTableHeader];
    [self registerNibViewForCell];
    [self addTableViewItems];
    
    //UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
   
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden=YES;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.tabBarController.tabBar setHidden:NO];
    if (![AppDelegate APP].user) {
        //ClyLoginViewController *login = [[ClyLoginViewController alloc]init];
        //[self presentViewController:login animated:YES completion:nil];
        //[self.navigationController pushViewController:login animated:YES];
    }
    
    if ([AppDelegate APP].user) {
        NSLog(@"login.... username=%@",[AppDelegate APP].user.username);
        
        NSString *url = [AppDelegate APP].user.img;
        [_userImgView setContentMode:UIViewContentModeScaleAspectFit];
        
        if([url hasPrefix:@"http"]){
            NSURL *httpurl = [NSURL URLWithString:url];
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:httpurl]];
            [_userImgView setImage:[img transformWidth:55 height:55]];
        }else{
            NSString *path = url;
            UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
            [_userImgView setImage:[img transformWidth:55 height:55]];
        }
        
        _headerView.usernameLabel.text = [AppDelegate APP].user.username;
        
        //[self setUpLocationTraker];
        
    }
    
    [_tableView reloadData];
}


-(void) addTableView{
    //self.automaticallyAdjustsScrollViewInsets = false;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    
}

-(void) addTableHeader{
    
    ClyMeHeaderView *header = [ClyMeHeaderView loadInstanceFromNib];
    
    header.frame = CGRectMake(0, 0, kScreenWidth, 184);
    header.delegate = self;
    header.userImgView.userInteractionEnabled = YES;
    //header.userInteractionEnabled = YES;
    _userImgView = header.userImgView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLogin:)];
    [_userImgView addGestureRecognizer:tap];
    
    _userImgView = header.userImgView;
    _tableView.tableHeaderView = header;
    _headerView = header;
  
    
}

-(void) registerNibViewForCell{
    UINib *nib = [UINib nibWithNibName:tableItemCellId bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:tableItemCellId];
}

- (void)addTableViewItems
{

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"myprofile" ofType:@"plist"];
    NSMutableArray  *menuArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    //NSArray         *mArray = [NSArray mu]
    _menuArray = menuArray;
    
    NSInteger count = menuArray.count;
    NSMutableArray *sectionM0 = [[NSMutableArray alloc] init];
    NSMutableArray *sectionM1 = [[NSMutableArray alloc] init];
    NSMutableArray *sectionM2 = [[NSMutableArray alloc] init];
    /*
    for(int i=0;i<3;i++){
        NSString *title = [menuArray[i] objectForKey:@"title"];
        NSString *icon = [menuArray[i] objectForKey:@"icon"];
        ClyMeTableItem *item = [[ClyMeTableItem alloc] initWithTitle:title icon:icon];
        [sectionM0 addObject:item];
    }*/
    for(int i=3;i<count-2;i++){
        NSString *title = [menuArray[i] objectForKey:@"title"];
        NSString *icon = [menuArray[i] objectForKey:@"icon"];
 
        ClyMeTableItem *item = [[ClyMeTableItem alloc] initWithTitle:title icon:icon];
        [sectionM1 addObject:item];
    }
    
    for(int i=count-2;i<count;i++){
        NSString *title = [menuArray[i] objectForKey:@"title"];
        NSString *icon = [menuArray[i] objectForKey:@"icon"];
        ClyMeTableItem *item = [[ClyMeTableItem alloc] initWithTitle:title icon:icon];
        [sectionM2 addObject:item];
    }
    
    //NSArray *section0 = [sectionM0 copy];
    NSArray *section1 = [sectionM1 copy];
    NSArray *section2 = [sectionM2 copy];
    _sections = @[section1,section2];
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionItem = _sections[section];

    return sectionItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionItems = _sections[indexPath.section];
    
    ClyMeTableItem *item  = sectionItems[indexPath.row];
    
    if([item.title isEqualToString:@"清理缓存"]){
        item.desc = [self getCacheSize];
    }
    
    ClyMeSimpleCell *cell = [[ClyMeSimpleCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.meItem = item;
    [cell setMeItem:item desc:item.desc];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 1){
        return 40;
    }
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *sectionItems = _sections[indexPath.section];
    ClyMeTableItem *item  = sectionItems[indexPath.row];
    //NSLog(@"%d",item.title);
    if([item.title isEqualToString:@"清理缓存"]){
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清理缓存" message:@"你确定要清理缓存吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击确认");
            
            [[ClyCacheManager manager] clearFile];
            item.desc = [self getCacheSize];
            //NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];//刷新
            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    if([item.title isEqualToString:@"扫一扫"]){
        ClyQrCodeViewController *vc = [[ClyQrCodeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if([item.title isEqualToString:@"离线下载"]){
        ClyDownloadListView *vc = [[ClyDownloadListView alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



-(NSString *) getCacheSize{

    CGFloat cacheSize = [ClyCacheManager manager].filePath;
    NSLog(@"cache size %f",_cacheSize);
    NSString *strCacheSize = [NSString stringWithFormat:@"%f",cacheSize];
    strCacheSize = [strCacheSize substringWithRange:NSMakeRange(0, 3)];
    strCacheSize = [strCacheSize stringByAppendingString:@"M"];
    
    return strCacheSize;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-44);
}





-(void) clickLogin:(UITapGestureRecognizer *)sender{
    NSLog(@"login...");
    if(![AppDelegate APP].user){
        ClyLoginViewController *vc = [[ClyLoginViewController alloc] init];
        vc.view.frame = self.view.bounds;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        [self changeUserImg];
        
    }
}

//-----------更新头像 开始----------------

-(void)changeUserImg{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择操作" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseFromPhotoAlbum];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseFromCamera];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)chooseFromPhotoAlbum{
    NSLog(@"chooseFromPhotoAlbum");
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //（选择类型）表示仅仅从相册中选取照片
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //指定代理，因此我们要实现UIImagePickerControllerDelegate,
    //UINavigationControllerDelegate协议
    imagePicker.delegate = self;
    //设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
    imagePicker.allowsEditing = YES;
    //显示相册
    [self presentViewController:imagePicker animated:YES completion:nil];
    //[imagePicker release];
}

-(void)chooseFromCamera{
    NSLog(@"chooseFromCamera");
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES; //允许用户编辑
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        //弹出窗口响应点击事件
        NSLog(@"没有检测到相头");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    //image 就是修改后的照片
    //将图片添加到对应的视图上
    //结束操作
    [self saveImage:image imageName:@"123.jpg"];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)saveImage:(UIImage *)currentImage imageName:(NSString *)imgName{
    
    NSData *imageData = [[NSData alloc] initWithData:
                         UIImageJPEGRepresentation(currentImage, 1.0)];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [[paths objectAtIndex:0] stringByAppendingString:@"/123.jpg"];
    [imageData writeToFile:documentsPath atomically:YES];
    
    [AppDelegate APP].user.img = documentsPath;
    
    NSLog(@"path=%@",documentsPath);
    
    NSLog(@"保存成功");
}

//-----------更新头像 结束----------------



//-------定时向服务器发送定位 开始----------
-(void) setUpLocationTraker{
    self.locationTracker = [[LocationTracker alloc] init];
    [self.locationTracker startLocationTracking];
    
    NSTimeInterval time = 10.0;
    self.locationUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self
                                                              selector:@selector(updateLocation)
                                                              userInfo:nil repeats:YES];
}

-(void)updateLocation {
    NSLog(@"开始获取定位信息...");
    //向服务器发送位置信息
    [self.locationTracker updateLocationToServer];
}

//-------定时向服务器发送定位 结束----------
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
