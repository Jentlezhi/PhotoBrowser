//
//  MJPhoto.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "MJPhoto.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"

@implementation MJPhoto

#pragma mark 截图

- (instancetype)init
{
    if (self = [super init])
    {
        _imageLoadStatus = mjDownLoading;
        _imageLoadProgress = 0.0;
    }
    return self;
}

- (UIImage *)capture:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


- (UIImage *)urlImage
{
    NSString *cacheKey = [[SDWebImageManager sharedManager] cacheKeyForURL:self.url];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
    return image;
}

- (void)imageWithProgressBlock:(void (^)(float))progress competionBlock:(void (^)(UIImage *,BOOL))competion
{
    if (_imageLoadStatus == mjDownLoadFinish)
    {
        if (progress)
        {
            progress(1.0);
        }
        if (competion)
        {
            competion(self.urlImage,YES);
        }
    }
    if (_imageLoadStatus == mjDownLoadError)
    {
        if (progress)
        {
            progress(0.0);
        }
        if (competion)
        {
            competion(nil,NO);
        }
    }
    self.progressBlock = progress;
    self.competionBlock = competion;
    [self downLoadImage];
}

- (void)downLoadImage
{
    [[SDWebImageManager sharedManager] downloadImageWithURL:self.url options:SDWebImageLowPriority|SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        float downLoadprogress = (float)receivedSize/expectedSize;
        _imageLoadProgress = downLoadprogress;
        if (self.progressBlock)
        {
            self.progressBlock(downLoadprogress);
        }
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        if (self.competionBlock)
        {
            self.competionBlock(image, !error);
        }
    }];
}

- (void)clearBlock
{
    self.progressBlock = nil;
    self.competionBlock = nil;
}

@end