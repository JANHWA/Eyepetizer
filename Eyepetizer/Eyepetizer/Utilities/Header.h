//
//  Header.h
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#ifndef Header_h
#define Header_h


#pragma mark - 头文件
#import "CHNetWorking.h"
#import "RootViewController.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "JHTableViewCell.h"
#import "MJExtension.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "MagicalRecord.h"


#pragma mark - 系统相关

#define KWS(ws) __weak typeof(&*self) ws=self
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#pragma mark - 网页相关

/**
 *    每日精选
 */

#define kChoice @"http://baobab.wandoujia.com/api/v1/feed?num=10&date=%@&vc=67&u=011f2924aa2cf27aa5dc8066c041fe08116a9a0c&v=1.8.0&f=iphone"

/**
 *    发现更多
 */
#define kDiscover @"http://baobab.wandoujia.com/api/v2/categories"

/**
 *    发现界面的各个分类接口
 */

#define kCategory @"http://baobab.wandoujia.com/api/v3/videos?categoryName=%@"

/**
 *    热门排行
 */
// 周排行
#define kWeekRank @"http://baobab.wandoujia.com/api/v3/ranklist?num=10&strategy=weekly&udid=827b85f24a1e4f48bdc0b6cdbb23f755457e835c&vc=80&vn=1.13.1&deviceModel=GT-N7102&first_channel=eyepetizer_baidu_market&last_channel=eyepetizer_baidu_market"
// 月排行
#define kMonthRank @"http://baobab.wandoujia.com/api/v3/ranklist?num=10&strategy=monthly&udid=827b85f24a1e4f48bdc0b6cdbb23f755457e835c&vc=89&vn=1.13.1&deviceModel=GT-N7102&first_channel=eyepetizer_baidu_market&last_channel=eyepetizer_baidu_market"
// 总排行
#define kAllRank @"http://baobab.wandoujia.com/api/v3/ranklist?num=10&strategy=historical&udid=827b85f24a1e4f48bdc0b6cdbb23f755457e835c&vc=89&vn=1.13.1&deviceModel=GT-N7102&first_channel=eyepetizer_baidu_market&last_channel=eyepetizer_baidu_market"

#endif /* Header_h */
