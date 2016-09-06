//
//  HCWebViewVC.m
//  PhotoBrowserDemo
//
//  Created by Jentle on 15/3/20.
//  Copyright (c) 2015年 Jentle. All rights reserved.
//

#import "HCWebViewVC.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "UIView+Extension.h"

@interface HCWebViewVC ()<UIWebViewDelegate>
@property (nonatomic,weak)UIWebView *myWebView;
@property (nonatomic,strong) NSMutableArray *arrayImagesList;
@end

@implementation HCWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    self.myWebView = webView;
    webView.dataDetectorTypes = UIDataDetectorTypeLink;
    webView.userInteractionEnabled = YES;
    webView.delegate = self;
    webView.scrollView.bounces = NO;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cool.qctt.cn/html/mobile/newsinfo?id=57379&userid=&hiddenTag=1/hiddenTag/1"]]];
}


#pragma mark- <UIWebViewDelegate>

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self addJavaScriptWithWebView:webView];
    [webView stringByEvaluatingJavaScriptFromString:@"setImage();"];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urls = [webView stringByEvaluatingJavaScriptFromString:@"getAllImageUrl();"];
    NSArray *arrimages = [urls componentsSeparatedByString:@","];

    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@"::"];
    if ([components[0] isEqualToString:@"clickgirl"]) {
        int imgIndex = [components[1] intValue];
        CGRect frame = CGRectMake([components[2] floatValue], [components[3] floatValue], [components[4] floatValue], [components[5] floatValue]);
        frame = CGRectMake(frame.origin.x, frame.origin.y  + 64, frame.size.width, frame.size.height);
        
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i = 0; i<arrimages.count; i++) {
            MJPhoto *photo = [[MJPhoto alloc] init];
            //提供源视图坐标
            if (imgIndex == i) {
                photo.frame = frame;
            }
            photo.url = [NSURL URLWithString:arrimages[i]];
            [arr addObject:photo];
        }
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = imgIndex;
        browser.photos = arr;
        [browser show];
        return NO;
        
    }
    return YES;
}

- (void)addJavaScriptWithWebView:(UIWebView *)webView {
    NSString *clickGirl = [[NSBundle mainBundle] pathForResource:@"webjs.js" ofType:nil];
    clickGirl = [NSString stringWithContentsOfFile:clickGirl encoding:NSUTF8StringEncoding error:nil];
    [webView stringByEvaluatingJavaScriptFromString:clickGirl];
}


@end
