//
//  DetailViewController.h
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoicModel.h"
#import "RootViewController.h"

@interface DetailViewController :RootViewController



@property (nonatomic, copy) NSString *detailTitle;
@property (nonatomic, copy) NSString *detailCategory;
@property (nonatomic, copy) NSString *detailDuration;
@property (nonatomic, copy) NSString *detailPlayUrl;
@property (nonatomic, copy) NSString *detailCoverForFeed;
@property (nonatomic, copy) NSString *detailDescription;
@property (nonatomic, copy) NSString *detailCoverBlurred;


@end
