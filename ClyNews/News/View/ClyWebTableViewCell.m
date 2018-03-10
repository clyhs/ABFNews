//
//  ClyWebTableViewCell.m
//  ClyNews
//
//  Created by 陈立宇 on 17/2/11.
//  Copyright © 2017年 陈立宇. All rights reserved.
//

#import "ClyWebTableViewCell.h"

@interface ClyWebTableViewCell()<UIWebViewDelegate>

@property (nonatomic,weak)   UIWebView *webView;

@property (nonatomic,strong) NSString  *htmlBody;

@property (nonatomic,assign) CGFloat webViewHeight;

@end



@implementation ClyWebTableViewCell

- (instancetype)initWithHtmlBody:(NSString *)htmlBody
{
    if (self = [super init]) {
        _webViewHeight = kScreenHeight-kNavHegiht;
        _htmlBody = htmlBody;
        //self.backgroundColor = [UIColor blueColor];//RGB_255(247, 247, 247);
        [self addWebView];
        [self loadWebHtml];
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    webView.backgroundColor = lineColor;
    webView.scalesPageToFit = NO;
    webView.delegate = self;
    webView.scrollView.bounces = NO;
    [webView setAutoresizingMask:UIViewAutoresizingNone];
    [webView.scrollView setScrollEnabled:NO];
    [webView.scrollView setScrollsToTop:NO];
    [self addSubview:webView];
    _webView = webView;
}

- (void)loadWebHtml
{
    NSURL *cssURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"News" ofType:@"css"]];
    NSLog(@"html:%@",_htmlBody);
    [_webView loadHTMLString:[self handleWithHtmlBody:_htmlBody] baseURL:cssURL];
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

#pragma mark -UIWebViewDelegate-已经开始加载Webview
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


#pragma mark -UIWebViewDelegate-已经加载Webview完毕
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"load finish");
    _webViewHeight = [[webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]floatValue]+12;
    NSLog(@"webViewHeight %.f",_webViewHeight);
    self.webHeight = _webViewHeight;
    if (_webViewDidFinishLoad) {
        _webViewDidFinishLoad();
    }
    [self setNeedsLayout];
}

-(void) setFrame:(CGRect)frame{
    
    frame.size.width = kScreenWidth;
    frame.size.height = _webViewHeight;
    [super setFrame:frame];
}
@end
