//
//  ClyQrCodeViewController.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/27.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyQrCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ClyQrAreaView.h"
#import "ClyQrBackgroundView.h"
#import "UIView+Frame.h"
#import "ClyNavigationBarView.h"

@interface ClyQrCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    AVCaptureSession * session;//输入输出的中间桥梁
    ClyQrAreaView *_areaView;//扫描区域视图
}

@property(nonatomic,weak) ClyNavigationBarView *navBar;

@end

@implementation ClyQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //扫描区域
    //[self addNavBar];
    
    CGRect areaRect = CGRectMake((kScreenWidth - 218)/2, (kScreenHeight - 218)/2, 218, 218);
    
    //半透明背景
    ClyQrBackgroundView *bacgrouView = [[ClyQrBackgroundView alloc]initWithFrame:self.view.bounds];
    bacgrouView.scanFrame = areaRect;
    [self.view addSubview:bacgrouView];
    
    //设置扫描区域
    _areaView = [[ClyQrAreaView alloc]initWithFrame:areaRect];
    [self.view addSubview:_areaView];
    
    //提示文字
    UILabel *label = [UILabel new];
    label.text = @"将二维码放入框内，即开始扫描";
    label.textColor = [UIColor whiteColor];
    label.y = CGRectGetMaxY(_areaView.frame) + 20;
    [label sizeToFit];
    label.center = CGPointMake(_areaView.center.x, label.center.y);
    [self.view addSubview:label];
    
    //返回键
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    backbutton.frame = CGRectMake(12, 26, 42, 42);
    [backbutton setBackgroundImage:[UIImage imageNamed:@"prev"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
    NSArray * devices = [AVCaptureDevice devices];
    NSLog(@"devices = %li", devices.count);
    if(devices.count != 0){
    
        /**
         *  初始化二维码扫描
         */
        
        //获取摄像设备
        AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        //创建输入流
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        //创建输出流
        AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
        
        //设置代理 在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        //设置识别区域
        //深坑，这个值是按比例0~1设置，而且X、Y要调换位置，width、height调换位置
        output.rectOfInterest = CGRectMake(_areaView.y/kScreenHeight, _areaView.x/kScreenWidth, _areaView.height/kScreenHeight, _areaView.width/kScreenWidth);
        
        //初始化链接对象
        session = [[AVCaptureSession alloc]init];
        //高质量采集率
        [session setSessionPreset:AVCaptureSessionPresetHigh];
        
        [session addInput:input];
        [session addOutput:output];
        
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        
        AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
        layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
        layer.frame=self.view.layer.bounds;
        
        [self.view.layer insertSublayer:layer atIndex:0];
        
        //开始捕获
        [session startRunning];

    }else{
        NSLog(@"没有摄像头");
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
}

//添加导航条
-(void) addNavBar{
    ClyNavigationBarView *navBar = [ClyNavigationBarView loadInstanceFromNib];
    navBar.frame = CGRectMake(0, 0, kScreenWidth, kNavHegiht);
    __typeof (self) __weak weakSelf = self;
   
    [navBar setNavBackHandle:^{
        [weakSelf goBackAction];
    }];
    
    [self.view addSubview:navBar];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [session stopRunning];//停止扫描
        [_areaView stopAnimaion];//暂停动画
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        
        //输出扫描字符串
        NSLog(@"%@",metadataObject.stringValue);
    }
}

- (void)goBackAction
{
    NSLog(@"goback");
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)clickBackButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
