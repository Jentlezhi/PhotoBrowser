//
//  MJZoomingScrollView.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJPhotoView.h"
#import "MJPhoto.h"
#import "MJPhotoLoadingView.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "MacroDefinition.h"

@interface MJPhotoView ()
{
    BOOL _doubleTap;
    UIImageView *_imageView;
    MJPhotoLoadingView *_photoLoadingView;
    
    BOOL _hide;
}
@end

@implementation MJPhotoView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.clipsToBounds = YES;
		// 图片
		_imageView = [[UIImageView alloc] init];
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:_imageView];
        
        // 进度条
        _photoLoadingView = [[MJPhotoLoadingView alloc] init];
		
		// 属性
        self.backgroundColor = [UIColor clearColor];
		self.delegate = self;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
		self.decelerationRate = UIScrollViewDecelerationRateFast;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // 监听点击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
    }
    return self;
}

#pragma mark - photoSetter
- (void)setPhoto:(MJPhoto *)photo
{
    [_photo clearBlock];
    _photo = photo;
    [self showImage];
}

#pragma mark 显示图片
- (void)showImage
{
    if (_photo.firstShow)
    { // 首次显示
//        _imageView.image = _photo.placeholder; // 占位图片
//        _photo.srcImageView.image = nil;
        
        // 不是gif，就马上开始下载
        if (![_photo.url.absoluteString hasSuffix:@"gif"])
        {
//            __unsafe_unretained MJPhotoView *photoView = self;
//            __unsafe_unretained MJPhoto *photo = _photo;
//            [_imageView setImageWithURL:_photo.url placeholderImage:_photo.placeholder options:SDWebImageRetryFailed|SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//                photo.image = image;
//                
//                // 调整frame参数
//                [photoView adjustFrame];
//            }];
            [self photoStartLoad];
            //[self adjustFrame];
        }
    }
    else
    {
        [self photoStartLoad];
    }

    // 调整frame参数
    [self adjustFrame];
}

#pragma mark 开始加载图片
- (void)photoStartLoad
{
    //设置占位图
    _imageView.image = ImagePlaceholder43;
    if (_photo.imageLoadStatus == mjDownLoadFinish)
    {
        [self photoDidFinishLoadWithImage:[_photo urlImage]];
    }
    else if (_photo.imageLoadStatus == mjDownLoading)
    {
        if ([_photoLoadingView isDescendantOfView:self])
        {
            [_photoLoadingView removeFromSuperview];
        }
        _photoLoadingView.progress = MAX(kMinProgress, _photo.imageLoadProgress);
        [_photoLoadingView showLoading];
        [self addSubview:_photoLoadingView];
        __weak MJPhotoView *ws = self;
        [_photo imageWithProgressBlock:^(float progress) {
            
            _photoLoadingView.progress = progress;
            
        } competionBlock:^(UIImage *image, BOOL downLoadSuccess) {
            
            _photo.image = image;
            
            [ws photoDidFinishLoadWithImage:image];
        }];
    }
    else
    {
        [self photoDidFinishLoadWithImage:nil];
    }
}

#pragma mark 加载完毕
- (void)photoDidFinishLoadWithImage:(UIImage *)image
{
    _imageView.image = image;
    if (image) {
        self.scrollEnabled = YES;
        //_photo.image = image;
        [_photoLoadingView removeFromSuperview];
        
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewImageFinishLoad:)]) {
            [self.photoViewDelegate photoViewImageFinishLoad:self];
        }
    } else {
        if ([_photoLoadingView isDescendantOfView:self])
        {
            [_photoLoadingView removeFromSuperview];
        }
        [self addSubview:_photoLoadingView];
        [_photoLoadingView showFailure];
    }
    
    // 设置缩放比例
    [self adjustFrame];
}
#pragma mark 调整frame
- (void)adjustFrame
{
	if (_imageView.image == nil) return;
    
    // 基本尺寸参数
    CGSize boundsSize = self.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize imageSize = _imageView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
	
	// 设置伸缩比例
    CGFloat minScale = boundsWidth / imageWidth;
	if (minScale > 1) {
		minScale = 1.0;
	}
	CGFloat maxScale = 2.0; 
	if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
		maxScale = maxScale / [[UIScreen mainScreen] scale];
	}
	self.maximumZoomScale = maxScale;
	self.minimumZoomScale = minScale;
	self.zoomScale = minScale;
    
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
    // 内容尺寸
    self.contentSize = CGSizeMake(0, imageFrame.size.height);
    
    // y值
    if (imageFrame.size.height < boundsHeight) {
        imageFrame.origin.y = floorf((boundsHeight - imageFrame.size.height) / 2.0);
	} else {
        imageFrame.origin.y = 0;
	}
    
    if (_photo.firstShow) { // 第一次显示的图片
        _photo.firstShow = NO; // 已经显示过了
        if (_photo.frame.origin.y < SCREEN_HEIGHT) {
            
            _imageView.frame = _photo.frame;
            
        }else {
            _imageView.frame = imageFrame;
            _imageView.alpha = 0;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.frame = imageFrame;
        } completion:^(BOOL finished) {
            
            [self photoStartLoad];
        }];
    } else {
        _imageView.frame = imageFrame;
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return _imageView;
}

#pragma mark - 手势处理
- (void)handleSingleTap:(UITapGestureRecognizer *)tap {
    _doubleTap = NO;
    [self performSelector:@selector(hide) withObject:nil afterDelay:0.2];
}
- (void)hide
{
    if (_doubleTap) return;
    _hide = YES;
    // 移除进度条
    [_photoLoadingView removeFromSuperview];
    self.contentOffset = CGPointZero;
    
    
    CGFloat duration = 0.2;
    
    [self performSelector:@selector(reset) withObject:nil afterDelay:duration];

    
    [UIView animateWithDuration:duration + 0.1 animations:^{
        
        if ( _photo.frame.origin.y > -_photo.frame.size.height &&_photo.frame.origin.y < SCREEN_HEIGHT) {
            _imageView.frame = _photo.frame;
//            self.alpha = 0;
        }else{
            _imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            self.alpha = 0;
        }

        
        // gif图片仅显示第0张
        if (_imageView.image.images) {
            _imageView.image = _imageView.image.images[0];
        }
        
        // 通知代理
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewSingleTap:)]) {
            [self.photoViewDelegate photoViewSingleTap:self];
        }
    } completion:^(BOOL finished) {

        
        // 通知代理
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewDidEndZoom:)]) {
            [self.photoViewDelegate photoViewDidEndZoom:self];
        }
    }];
}

- (void)reset
{
    _imageView.image = _photo.capture;
    _imageView.contentMode = UIViewContentModeScaleToFill;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    _doubleTap = YES;
    
    CGPoint touchPoint = [tap locationInView:self];
	if (self.zoomScale == self.maximumZoomScale) {
		[self setZoomScale:self.minimumZoomScale animated:YES];
	} else {
		[self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
	}
}

- (void)dealloc
{
    // 取消请求
  //  [_imageView setImageWithURL:[NSURL URLWithString:@"file:///abc"]];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@"file:///abc"]];
}
@end