//
//  MJPhoto.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MJImageLoadStatus)
{
    mjDownLoading,
    mjDownLoadFinish,
    mjDownLoadError
};



@interface MJPhoto : NSObject
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *image; // 完整的图片

//@property (nonatomic, strong) UIImageView *srcImageView; // 来源view

@property (nonatomic, assign) CGRect frame; // 点击图片的位置
@property (nonatomic, strong, readonly) UIImage *placeholder;
@property (nonatomic, strong, readonly) UIImage *capture;

@property (nonatomic, assign) BOOL firstShow;

// 是否已经保存到相册
@property (nonatomic, assign) BOOL save;
@property (nonatomic, assign) int index; // 索引

//新加的....
@property (nonatomic, assign, readonly) MJImageLoadStatus imageLoadStatus;
@property (nonatomic, assign, readonly) float  imageLoadProgress;
@property (nonatomic, weak, readonly)   UIImage *urlImage;
@property (nonatomic, copy) void(^progressBlock)(float);
@property (nonatomic, copy) void(^competionBlock)(UIImage*,BOOL);

- (void)imageWithProgressBlock:(void(^)(float))progress competionBlock:(void(^)(UIImage *,BOOL))competion;
- (void)clearBlock;

@end