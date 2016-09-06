//
//  MacroDefinition.h
//  PhotoBrowserDemo
//
//  Created by Jentle on 15/3/20.
//  Copyright (c) 2015年 Jentle. All rights reserved.
//

#ifndef CarModelHeadlines_MacroDefinition_h
#define CarModelHeadlines_MacroDefinition_h
#import "SVProgressHUD.h"
#ifdef DEBUG
#define TTLog(...) NSLog(__VA_ARGS__)
#else
#define TTLog(...)
#endif

#pragma mark 系统宏
//系统
#define IOS8 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)
#define IOS7 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)
#define iOSVersion   [[[UIDevice currentDevice]systemVersion] floatValue]
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
//屏幕
#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT     [[UIScreen mainScreen] bounds].size.height


#pragma mark 单例管理
//主题单例模式
#define  TTKThemeStyleM  [TTThemeStyleManager shareManager]
#define TTKCoreData   [TTCoreDataManager shareManager]// 数据库管理类
//视频播放
#define TTKAudioPlayer [TTAudioPlayerManager sharedInstance]
//用户管理宏
#define TTKUserManaer [TTUserManager shareManager]
#define  TTKConfigManager  [TTConfigManager shareManager]

#define KNotiCenter  [NSNotificationCenter defaultCenter]

#pragma mark 颜色宏
#define kNavColor @"#f7f7f7" //导航颜色
#define kTagColor [UIColor colorWithHexString:@"#17abc1"]
#define kColor(a,b,c) [UIColor colorWithRed:(a)/255.0 green:(a)/255.0 blue:(a)/255.0 alpha:1]
//颜色
#define setNaviColor    [UIColor colorWithRed:35.0/255 green:39.0/255 blue:48.0/255 alpha:1.0]
//青色的色值
#define setCyanColor kTagColor
//灰色
#define setBackColor  [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]

//首页菜单背景颜色
#define setMenuBack     [UIColor colorWithHexString:kNavColor]

#define setColor    kTagColor

#define kThemeTextColor [UIColor colorWithHexString:@"#333333"]
#define kTitleTextColor [UIColor colorWithHexString:@"#525252"]
#define kTextColor [UIColor colorWithHexString:@"#999999"]

#define setBackGrayColor [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]
#define setColorEBEBEB   [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]
//灰色字体颜色
#define setGrayFontColor [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1]
//分割线
#define setSeparatorColor        [UIColor colorWithHexString:@"e2e2e2"]

//设置大标题颜色
#define setTitlecolor    [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
//已经阅读后颜色值
#define setHasReadColor    [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]
#define setRedcolor  [UIColor colorWithRed:233/255.0 green:81/255.0 blue:81/255.0 alpha:1]
#define setNaviGrayColor    [UIColor colorWithRed:248/255.2f green:248/255.2f blue:248/255.2f alpha:1]

//新增首页菜单选中颜色和未选中颜色以及下划线颜色
#define colorWithHex(hex)  [UIColor colorWithHexString:(hex)]

#define khomeMenuBackground    colorWithHex(@"#f7f7f7") //首页导航颜色
#define kNavigationBarItemTitleColor colorWithHex(@"#525252") //统一导航栏item字体颜色
#define homeMenuSelectedColor  colorWithHex(@"#17abc1")
#define homeMenuNormalColor    colorWithHex(@"#525252")
#define homeMenuLineColor      colorWithHex(@"#17abc1")


# pragma mark 视图大小尺寸等定义
#define kUI_Width(a) ((a/320.0) * SCREEN_WIDTH)
#define kUI_Height(a) ((a/568.0) * SCREEN_HEIGHT)

#define iPhone4 (SCREEN_HEIGHT == 480.0)

#define kNavBarHeight 64
#define kSysFont(a) [UIFont systemFontOfSize:a]

#define kLineWidth 1

#define MLNavigationPopBack @"MLNavigationPopBack"


#pragma mark 默认占位图
//设置默认背景图，
#define ImagePlaceholder21  [UIImage imageNamed:@"TwoToOne"]
#define ImagePlaceholder11  [UIImage imageNamed:@"OneToOne"]
#define ImagePlaceholder43  [UIImage imageNamed:@"FourToThree"]

//主题单例模式
#define  TTKThemeStyleM  [TTThemeStyleManager shareManager]

//视频频道
#define VideoLastRefreshTime @"last_refresh_time"
#define VideoNewOffset @"new_offset"
#define VideoOldOffset @"old_offset"




#define USER_NAME       @"USER_NAME1"//用户名
#define USER_NICKNAME   @"USER_NICKNAME"//昵称
#define USER_VERIFYKEY  @"USER_verifyKey"//用户验证key
#define USER_PHONENUMER @"USER_PHONENUMER"//用户手机号
#define USER_IMAGE      @"USER_IMAGE"//用户头像
#define USER_PASSWORD   @"USER_PASSWORD"//用户密码
#define USER_ID         @"USER_ID"//用户id
#define USER_grade      @"USER_grade"//用户头衔
#define USER_JOIN       @"USER_JOIN" //用户注册时间
#define USER_PERMISSION @"USER_PERMISSION" //发布权限
#define SHOWADVER       @"SHOWADVER"//是否显示开屏广告
#define LOADCOUNT       10//一次加载数量
#define USER_LOCALCity      @"USER_LOCALCity"//用户当前城市
#define USER_CurrentCity      @"USER_CurrentCity"//用户显示城市
#define USER_CurrentCity_Notification @"USER_CurrentCity_Notification" //本地定位成功通知
//首页进入时候开屏广告加载，
#define  LOAD_OPENSCREEN_ADVER        @"laodOpenScreenAdvertising"
/**
 *  屏幕旋转方向
 *
 *  @return 保存屏幕方向值
 */
#define SCREEN_DIRECTION   @"SCREEN_DIRECTION"

#define kDataError @"数据加载失败"
#define kNetError @"网络连接失败"
#define kRequestIndicator @"加载中..."

#pragma mark 常用方法宏
/**请求数据时提示框*/
#define kSVPWaitingReqeustData [SVProgressHUD showWithStatus:kRequestIndicator];//等待请求数据
//联网失败
#define kSVPReqeustDataError [SVProgressHUD showErrorWithStatus:kNetError];

#define kSVPDismiss  [SVProgressHUD dismiss];


/**
 *根据宽高请求对应图片
 sourceURL:源图地址
 limitW：请求图片宽
 limitH：请求图片高
 */
#define kDescImage(sourceURL,limitW,limitH) [NSString stringWithFormat:@"%@?imageView2/0/w/%ld/h/%ld",(sourceURL),(NSInteger)(limitW),(NSInteger)(limitH)]

/**
 *  精华文章中加载图片使用
 *
 *  @param sourceURL 图片源地址
 *  @param limitW    所需请求宽度
 */
#define kDescImageW(sourceURL,limitW) [NSString stringWithFormat:@"%@?imageView2/0/w/%ld",(sourceURL),(NSInteger)(limitW)]


#define kInputViewPlaceHolder @"评论最多150个字"

#endif
