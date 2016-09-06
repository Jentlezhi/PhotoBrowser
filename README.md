#### 图片浏览器，浏览web页图片、浏览ImageView

#####使用示例:
* 1、#import "MJPhoto.h"
* 2、#import "MJPhotoBrowser.h"


#####浏览ImageView:
```
- (void)networkImageShow:(NSUInteger)index{
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i<self.srcStringArray.count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        UIImageView *srcImageView = [self.view viewWithTag:i + 1000];
        photo.frame = [srcImageView convertRect:srcImageView.bounds toView:nil];
        photo.url = [NSURL URLWithString:self.srcStringArray[i]];
        [arr addObject:photo];
    }
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index;
    browser.photos = arr;
    [browser show];
}

```
#####浏览web页ImageView:
```
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

```



效果演示:

![](PhotoBrowserDemo.gif)
