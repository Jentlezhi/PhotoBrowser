//
//  HCTableViewController.m
//  PhotoBrowserDemo
//
//  Created by Jentle on 15/3/20.
//  Copyright (c) 2015年 Jentle. All rights reserved.
//

#import "HCTableViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "MacroDefinition.h"

#define ImageMargin 30

@interface HCTableViewController ()

@property (nonatomic, strong) NSArray *srcStringArray;
@end

@implementation HCTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"图片浏览";
    
    _srcStringArray = @[@"http://ww2.sinaimg.cn/thumbnail/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/67307b53jw1epqq3bmwr6j20c80axmy5.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                        @"http://ww4.sinaimg.cn/thumbnail/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                        @"http://ww4.sinaimg.cn/thumbnail/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg"
                        ];
    
    
    [self setupUI];
}

- (void)setupUI
{
    NSInteger imageCount = self.srcStringArray.count;
    NSInteger perRowImageCount = ((imageCount == 4) ? 2 : 3);
    CGFloat w = 80;
    CGFloat h = 80;

        for (int i = 0; i<9; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            int rowIndex = i / perRowImageCount;
            int columnIndex = i % perRowImageCount;
            CGFloat x = ImageMargin + columnIndex * (w + ImageMargin);
            CGFloat y = rowIndex * (h + ImageMargin)+ 200;

            imageView.frame = CGRectMake(x, y, w, h);
            imageView.tag = i + 1000;
            [imageView sd_setImageWithURL:self.srcStringArray[i] placeholderImage:ImagePlaceholder43];
            [self.view addSubview:imageView];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLookBigImage:)];
            [imageView addGestureRecognizer:tap];
        }
}



- (void)tapLookBigImage:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag - 1000;
    //展示网络图片
    [self networkImageShow:index];
}

- (void)networkImageShow:(NSUInteger)index{
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i<self.srcStringArray.count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        //提供源视图坐标
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

@end
